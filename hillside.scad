// OpenSCADvent heightmap hillside
// Space Buck, December 2020

use <handyfunctions.scad>;

// Method 1: Preserves the projection area
module hillside(angle) {
  // Create the base on which we'll place the heightmap
  difference() {
    skewzx(tan(angle+0.1)) rz(-45) mz() cube(299); // I had some non-manifold problems so I boosted the angle a teeny bit
    mz() xy();
  }
  
  // Skew the heightmap
  skewzx(tan(angle)) rz(-45) sz(0.5) surface(file="Perlin.png");
}


// Method 2: Preserves surface area
module hillside2(angle) {
  // Create the base on which we'll place the heightmap
  difference() {
    skewzx(tan(angle)) sx(cos(angle)) rz(-45) mz() cube(299);
    mz() cylinder(r=500, h=300);
  }
  
  // Rotate and skew the heightmap
  ry(-angle) skewxz(tan(angle)) rz(-45) sz(0.5) surface(file="Perlin.png");
}

hillside(20);