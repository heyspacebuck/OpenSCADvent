// OpenSCADvent wrap cylinder
// Space Buck, December 2020

use <handyfunctions.scad>;

module wrap_cylinder(r, extrusion, segmentSize=1, minAngle=0, maxAngle=360, minHeight=0, maxHeight=1000) {
  for (theta = [minAngle:segmentSize:(maxAngle-segmentSize)]) {
    rz(theta) rotate_extrude(angle=segmentSize) {
      dx(r) projection(cut=true) {
        dz(theta) rz(90) ry(90) rx(90) linear_extrude(height=extrusion) children();
      }
    }
  }
}

module poem() {
  text(size=20, "this is just to say i have eaten the plums that were in the icebox and which you were probably saving for breakfast forgive me they were delicious so sweet and so cold");
}

module wrappedPoem() {
  for (i = [0:1:9]) {
    dx(-360*i) intersection() {
      dx(360*i) square(360, 220);
      dy(120) rz(atan2(-20, 360)) poem();
    }
  }
}

*wrap_cylinder(20, 1) {
  dy(10) sx(7) dx(10) circle(10);
}

*wrap_cylinder(20, 1) {
  sx(2.5) text("is this manifold??");
}

cylinder(r=40, h=140, $fn=64);
wrap_cylinder(40, 1, segmentSize=.25) wrappedPoem();