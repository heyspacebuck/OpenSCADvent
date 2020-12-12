// OpenSCADvent Hanunó'o love poem
// Space Buck, December 2020
// "Noto Sans Hanunoo" can be obtained here: https://www.google.com/get/noto/#sans-hano

use <handyfunctions.scad>
use <NotoSansHanunoo-Regular.ttf>

$fn=64;

poem = [
["ᜣ","ᜯᜳ","ᜧᜲ","ᜥ","ᜦ","ᜠ","ᜰ"],
["ᜦᜲ","ᜫ","ᜮ","ᜰᜲ","ᜠ","ᜬ","ᜤ"],
["ᜩ","ᜫᜲ","ᜣ","ᜩ","ᜫ","ᜬ","ᜬ"],
["ᜩ","ᜮ","ᜩ","ᜫ","ᜮ","ᜯᜲ","ᜨ"],
["ᜡ","ᜧ","ᜧᜲ","ᜪ","ᜧᜲ","ᜮᜲ","ᜱ"],
["ᜰᜲ","ᜫ","ᜤᜲ","ᜮ","ᜪ","ᜤᜳ","ᜠ"],
["ᜢ","ᜫ","ᜫ","ᜭᜳ","ᜩ","ᜢ","ᜬ"],
["ᜫ","ᜨ","ᜧ","ᜧᜲ","ᜪᜳ","ᜪᜳ","ᜥ"],
["ᜫ","ᜥᜳ","ᜩᜲ","ᜧᜲ","ᜦ","ᜤᜲ","ᜣ","᜶"]
];

lines = len(poem);

module roundPoem(radius) {
  for (line = [0:lines]) {
    glyphs = len(poem[line]);
    for (glyph = [0:glyphs]) {
      rx(30*line) dz(radius) dy(-5) dx(18*glyph) linear_extrude(4) {
        text(poem[line][glyph], font="Noto Sans Hanunoo", halign="center");
      }
    }
  }
}

difference() {
  color("green") dx(-30) ry(90) cylinder(r=33, h=170);
  color("white") roundPoem(30);
}