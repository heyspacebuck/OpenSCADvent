// OpenSCADvent Vilaka cookie cutters
// Space Buck, December 2020

// Original SVG taken from Wikimedia Commons https://commons.wikimedia.org/wiki/File:Escudo_Vilaka.svg

use <handyfunctions.scad>;
$fn=32;

cutting_height = 12;
stamping_height = 9;

seal_cookie();
rz(90) hedgehog_cookie();
dy(-50) flower_cookie();


module hedgehog(thickness) {
  difference() {
    import("assets/vilaka_spikes.svg");
    offset(r=-thickness) import("assets/vilaka_spikes.svg");
  }

  difference() {
    offset(r=thickness) import("assets/vilaka_face.svg");
    import("assets/vilaka_face.svg");
  }
}

module flower(thickness) {
  dx(-31) dy(-30) difference() {
    offset(r=thickness) import("assets/vilaka_flower.svg");
    import("assets/vilaka_flower.svg");
  }
}

module flowerdots() {
  dy(5) circle(2.5);
  rz(90) dy(5) circle(2.5);
  rz(180) dy(5) circle(2.5);
  rz(270) dy(5) circle(2.5);
}

module shield() {
  union() {
    dy(133) dx(133) circle(133);
    dy(133) square([266, 175]);
  }
}

module seal_cookie() {
  // Scale the whole thing down in x and y, but not z
  sx(0.22) sy(0.22) {
    // The cookie edge
    linear_extrude(cutting_height) {
      difference() {
        offset(r=3) shield();
        shield();
      }
    }
    
    // The cookie stamp details
    linear_extrude(stamping_height) {
      hedgehog(3);
      dy(261) dx(133) flower(3);
      dy(261) dx(50) flower(3);
      dy(261) dx(216) flower(3);
      dy(210) dx(133) square([200, 8], center=true);
    }
    
    // The supports to make this theoretically usable as a cookie cutter
    linear_extrude(1) {
      difference() {
        offset(r=15) shield();
        offset(r=-25) shield();
      }
      difference() {
        offset(r=15) import("assets/vilaka_spikes.svg");
        offset(r=-15) import("assets/vilaka_spikes.svg");
      }
      dy(215) dx(133) square([266, 50], center=true);
    }
  }
}

module hedgehog_cookieborder(thickness) {
  difference() {
    offset(r=12+thickness) hull() hedgehog(thickness);
    offset(r=12) hull() hedgehog(thickness);
  }
}

module hedgehog_cookie() {
  sy(0.3) sx(0.3) {
    // Cookie border
    linear_extrude(cutting_height) hedgehog_cookieborder(3);
    
    // Stamping details
    linear_extrude(stamping_height) hedgehog(3);
    
    // Rim to make it useable
    linear_extrude(1) {
      difference() {
        offset(r=24) hull() hedgehog(3);
        offset(r=-10) import("assets/vilaka_spikes.svg");
      }
    }
  }
}

module flower_cookie() {
  linear_extrude(cutting_height) flower(1);
  linear_extrude(stamping_height) flowerdots();
  linear_extrude(1) {
    flower(6);
    circle(15);
  }
}