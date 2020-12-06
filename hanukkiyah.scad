// OpenSCADvent chaotic hanukkiyah/menorah
// Space Buck, December 2020

use <handyfunctions.scad>;
use <torus.scad>;
$fn = 32;

height=10;
function random() = rands(0,1,1)[0];

module candleholder() {
  rotate_extrude($fn=6) polygon(points=[[0,0],[1,0],[1,.2],[.5,.2],[.8,1],[.8,1.2], [.3,1.2], [.3,.6], [0,.6]]);
}

module base() {
  rotate_extrude() difference() {
    union() {
      dy(-1) dx(4) circle(2);
      square([4,1]);
      square([3,3]);
    }
    dx(3) dy(3) circle(2);
    projection() my() xz();
  }
}

module shamash(segment=0.1) {
  function widthfxn(x) = 0.5 + 0.25*(1 + cos(900*x/height));
  for (z = [0:segment:height]) {
    dz(3+z) cylinder(h = segment, r1 = widthfxn(z), r2 = widthfxn(z + segment));
  }
  dz(3+height) candleholder();
}

module branch() {
  r = 3 + 27*random();
  theta = 360*random();
  phi = -30 + 60*random();
  
//  curve1Radius = 1+6*random();
  curve1Radius = min((.1+.6*random())*height, 0.5*r);
//  curve2Radius = 8-curve1Radius;
  curve2Radius = min(height-curve1Radius, 0.5*r);
  
  //dz(curve1Radius + curve2Radius + 3) rz(theta) dx(r) rx(phi) candleholder();
  rz(180+theta) dz(3) dx(-curve1Radius) rx(90) torus(curve1Radius, .5, 90, rounded=true);
  rz(theta) dx(curve1Radius) dz(3 + curve1Radius) ry(90) cylinder(r=0.5, h=r - curve1Radius - curve2Radius);
  rz(-90+theta) dy(r - curve2Radius) dz(curve1Radius + 3) ry(phi) dz(curve2Radius) ry(90) torus(curve2Radius, .5, 90, rounded=true);
  rz(theta) dz(3 + curve1Radius) dx(r - curve2Radius) rx(phi) dx(curve2Radius) dz(curve2Radius) candleholder();
}

base();
shamash();
numCandles = 8 + floor(13*random());
for (i = [1:numCandles]) {
  branch();
}