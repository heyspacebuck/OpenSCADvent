// OpenSCADvent Meissner Dice
// Space Buck, December 2020

use <handyfunctions.scad>
use <vec3math.scad>
use <meissner.scad>

$fn=64;

pt = [0, 0, 10];

meissnerdice(pt);

module meissnerdice(point) {
  dx(-norm(point)) meissnerdie(point, "Y");
  dx(norm(point)) meissnerdie(point, "delta");
}

module meissnerdie(point, type) {
  dihedral = atan(sqrt(2));
  
  // For my benefit, transform the coordinate space so the given point is on the z-axis for the rest of the calculations
  theta = 90 - atan2(point.z, point.x);
  phi = 90 - atan2(point.z*cos(theta) + point.x*sin(theta), point.y);
  
  // Calculate the vertices of the Meissner tetrahedron given a point p0 on the z-axis
  p0 = [0, 0, norm(point)];
  p1 = ry(p0, dihedral*2);
  p2 = rz(p1, 120);
  p3 = rz(p2, 120);
  radius = norm(p0 - p1);
  
  ry(theta) rx(-phi) difference() {
    meissner(p0, type);
    translate(p0) ry(180 - dihedral/2 + 5) rz(90) dz(radius) linear_extrude(norm(p0)/10, center=true) text("1", size=norm(p0)/3, halign="center", valign="center");
    translate(p0) rz(120) ry(180 - dihedral/2 + 5) rz(90) dz(radius) linear_extrude(norm(p0)/10, center=true) text("2", size=norm(p0)/3, halign="center", valign="center");
    translate(p0) rz(-120) ry(180 - dihedral/2 + 5) rz(90) dz(radius) linear_extrude(norm(p0)/10, center=true) text("3", size=norm(p0)/3, halign="center", valign="center");
    translate(p1) ry(2*dihedral) ry(180 + dihedral/2 - 5) rz(-90) dz(radius) linear_extrude(norm(p0)/10, center=true) text("4", size=norm(p0)/3, halign="center", valign="center");
  translate(p1) ry(2*dihedral) rz(120) ry(180 + dihedral/2 - 5) rz(-90) dz(radius) linear_extrude(norm(p0)/10, center=true) text("3", size=norm(p0)/3, halign="center", valign="center");
  translate(p1) ry(2*dihedral) rz(-120) ry(180 + dihedral/2 - 5) rz(-90) dz(radius) linear_extrude(norm(p0)/10, center=true) text("2", size=norm(p0)/3, halign="center", valign="center");
  rz(120) translate(p1) ry(2*dihedral) ry(180 + dihedral/2 - 5) rz(-90) dz(radius) linear_extrude(norm(p0)/10, center=true) text("4", size=norm(p0)/3, halign="center", valign="center");
  rz(120) translate(p1) ry(2*dihedral) rz(120) ry(180 + dihedral/2 - 5) rz(-90) dz(radius) linear_extrude(norm(p0)/10, center=true) text("1", size=norm(p0)/3, halign="center", valign="center");
  rz(120) translate(p1) ry(2*dihedral) rz(-120) ry(180 + dihedral/2 - 5) rz(-90) dz(radius) linear_extrude(norm(p0)/10, center=true) text("3", size=norm(p0)/3, halign="center", valign="center");
  rz(-120) translate(p1) ry(2*dihedral) ry(180 + dihedral/2 - 5) rz(-90) dz(radius) linear_extrude(norm(p0)/10, center=true) text("4", size=norm(p0)/3, halign="center", valign="center");
  rz(-120) translate(p1) ry(2*dihedral) rz(120) ry(180 + dihedral/2 - 5) rz(-90) dz(radius) linear_extrude(norm(p0)/10, center=true) text("2", size=norm(p0)/3, halign="center", valign="center");
  rz(-120) translate(p1) ry(2*dihedral) rz(-120) ry(180 + dihedral/2 - 5) rz(-90) dz(radius) linear_extrude(norm(p0)/10, center=true) text("1", size=norm(p0)/3, halign="center", valign="center");
  }
}