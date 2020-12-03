// OpenSCADvent random bivalve
// Space Buck, December 2020

include <handyfunctions.scad>;

function random() = rands(0,1,1)[0];

import("clam_bottom.stl");
rx(45*random()) import("clam_top.stl");

$fn=64;
if (random() > 0.5) {
  dy(10) sphere(r=3+4*random());
}

