// OpenSCADvent random letters on a hillside
// Space Buck, December 2020

use <handyfunctions.scad>
use <hillside.scad>

function random() = rands(0,1,1)[0];

angle = 20; // Slope of the hillside
glyphs = ["ߒߞߏ", "ᏣᎳᎩ", "ދިވެހި", "ꆈꌠꉙ"]; // Glyphs to scatter along the hillside
font = "DejaVu Sans"; // Make sure you pick a font that (a) exists on your machine and (b) supports the glyphs you want to represent!

hillside(20);

for (glyph = glyphs) {
  x = 50 + 200*random();
  y = 50 + 200*random();
  z = 30 + 20*random();
  theta = -45 + 90*random();
  phi = -30 + 60*random();
  
  color("grey") dz(z) ry(-angle) rz(-45) dx(x) dy(y) rz(-45) ry(theta) rx(90-angle+phi) linear_extrude(center=true, height=15) {
    text(glyph, size=40, halign="center", valign="center", font=font);
  }
}