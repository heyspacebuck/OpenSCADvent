// OpenSCADvent Meissner Tetrahedra
// Space Buck, December 2020

use <handyfunctions.scad>;
use <vec3math.scad>;

$fn=96;

// This OpenSCAD construction of the Meissner tetrahedra stands out because it computes all the geometric relations within OpenSCAD. Just give it a single vertex (and the dihedral angle) and OpenSCAD figures out the rest.

meissners([0, 0, 10]);







// * * * * * * * * * * * * *
//
// The dihedral angle is all we start with!
dihedral = atan(sqrt(2));


// When given the points in the specific order that I give them, this function generates a tetrahedron with all normals facing outwards (this is critical for boolean operations).
module tetrahedron(p0, p1, p2, p3) {
  polyhedron(points = [p0, p1, p2, p3], faces = [[0,2,1], [0,1,3], [0,3,2], [1,2,3]]);
}

// This is the Reuleaux tetrahedron. Not a solid of constant width.
module reuleaux(p0, p1, p2, p3) {
  reuleauxRadius = norm(p1 - p0);
  intersection() {
    translate(p0) sphere(reuleauxRadius);
    translate(p1) sphere(reuleauxRadius);
    translate(p2) sphere(reuleauxRadius);
    translate(p3) sphere(reuleauxRadius);
  }
}

// To construct a Meissner tetrahedron, we must remove three patches and replace them with a smooth rotation. This function removes six patches.
module clippedReuleaux(p0, p1, p2, p3) {
  union() {
    for (point = [p0, p1, p2, p3]) {
      intersection() {
        reuleaux(p0, p1, p2, p3);
        translate(-point) tetrahedron(2*p0, 2*p1, 2*p2, 2*p3);
      }
    }
  }
}

// Join different parts of clippedReuleaux() and reuleaux(), depending of if we are making a "Y" or "delta" Meissner body.
module clippedMeissner(p0, p1, p2, p3, meissnerType) {
  if (meissnerType == "Y") {
    union() {
      difference() {
        reuleaux(p0, p1, p2, p3);
        dz(p1.z) xy();
      }
      intersection() {
        clippedReuleaux(p0, p1, p2, p3);
        dz(p1.z) xy();
      }
    }
  } else {
    union() {
      intersection() {
        reuleaux(p0, p1, p2, p3);
        dz(p1.z) xy();
      }
      difference() {
        clippedReuleaux(p0, p1, p2, p3);
        dz(p1.z) xy();
      }
    }
  }
}

// A single rotation used to smooth the clipped portions
module roundBit(p0, p1, p2, p3) {
  reuleauxRadius = norm(p1 - p0);
  dz(-reuleauxRadius/2) rz(-90+dihedral) rotate_extrude(angle=180-2*dihedral) {
    intersection() {
      dx(-tan(dihedral)*norm(p0)) circle(r=reuleauxRadius);
      projection() yz();
    }
  }
}

// Arrange all the smoothing rotations into the appropriate configuration
module roundBits(p0, p1, p2, p3, meissnerType) {
  if (meissnerType == "Y") {
    dz(p0.z) ry(-90+dihedral) roundBit(p0, p1, p2, p3);
    rz(120) dz(p0.z) ry(-90+dihedral) roundBit(p0, p1, p2, p3);
    rz(240) dz(p0.z) ry(-90+dihedral) roundBit(p0, p1, p2, p3);
  } else {
    translate(p3) ry(90+dihedral) rx(90) roundBit(p0, p1, p2, p3);
    rz(120) translate(p3) ry(90+dihedral) rx(90) roundBit(p0, p1, p2, p3);
    rz(240) translate(p3) ry(90+dihedral) rx(90) roundBit(p0, p1, p2, p3);
  }
}

// Create the full Meissner body
module meissner(point, meissnerType) {
  // For my benefit, transform the coordinate space so the given point is on the z-axis for the rest of the calculations
  theta = 90 - atan2(point.z, point.x);
  phi = 90 - atan2(point.z*cos(theta) + point.x*sin(theta), point.y);
  
  // Calculate the vertices of the Meissner tetrahedron given a point p0 on the z-axis
  p0 = [0, 0, norm(point)];
  p1 = ry(p0, dihedral*2);
  p2 = rz(p1, 120);
  p3 = rz(p2, 120);
  
  // Finally, combine the clipped Meissner body and the smoothing rotations to create the full Meissner body
  ry(theta) rx(-phi) union() {
    clippedMeissner(p0, p1, p2, p3, meissnerType);
    roundBits(p0, p1, p2, p3, meissnerType);
  }
}

// Generate one of each Meissner tetrahedron, given only one vertex
module meissners(point) {
  dx(-norm(point)) meissner(point, "Y");
  dx(norm(point)) meissner(point, "delta");
}