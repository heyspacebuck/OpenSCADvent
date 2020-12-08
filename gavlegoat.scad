// OpenSCADvent Gavle Goat
// Space Buck, December 2020

use <handyfunctions.scad>;
use <torus.scad>;
$fn = 32;

module goat() {
  //dy(4) dx(-8) cylinder(r=4, h=18);
  //dy(-4) dx(-8) cylinder(r=4, h=18);
  //dy(4) dx(8) cylinder(r=4, h=18);
  dy(-5) dx(9) skewyz(.1) skewxz(-.1) cylinder(r=4, h=18);
  my() dy(-5) dx(9) skewyz(.1) skewxz(-.1) cylinder(r=4, h=18);
  mx() {
    dy(-5) dx(9) skewyz(.1) skewxz(-.1) cylinder(r=4, h=18);
    my() dy(-5) dx(9) skewyz(.1) skewxz(-.1) cylinder(r=4, h=18);
  }

  dz(18) dx(-8) ry(90) cylinder(r=8, h=16);
  dz(18) dx(-8) sx(.75) sphere(8);
  dz(18) dx(8) sx(.75) sphere(8);
  dz(20) dx(-11) sx(.5) skewxz(-.4) cylinder(h=12, r1=3, r2=1);
  dz(18) dx(8) skewxz(.1) cylinder(h=15, r1=6, r2=4);
  dz(35) dx(6) ry(100) cylinder(h=12, r1=6, r2=4);
  dz(24) dx(17) sx(.5) skewxz(-.4) cylinder(h=8, r1=1, r2=3);

  dz(32) dy(-3) dx(1)  rx(95) rz(10) torus(9, 2, 270);
  my() dz(32) dy(-3) dx(1)  rx(95) rz(10) torus(9, 2, 270);
}

function random() = rands(0, 1, 1)[0];

color("tan") goat();

if ($t > 0) {
  for (x = [0:20]) {
    flameColorIndex = floor(3*random());
    flameColor = ["red", "orange", "yellow"][flameColorIndex];
    flameType = round(random());
    string = flameType == 1 ? "assets/Fire_Game_Piece_A.STL" : "assets/Fire_Game_Piece_B.STL";
    x = -15 + 30*random();
    y = -10 + 20*random();
    z = 40*random();
    theta = -30 + 60*random();
    phi = -30 + 60*random();
    
    color(flameColor) translate([x, y, z]) ry(theta) rx(90 + phi) sz(.33) scale(0.2) import(string);
  }
}