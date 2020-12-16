// Steps toward a Hershey-font-based polygon font
// Space Buck, December 2020
// Works cited: http://paulbourke.net/dataformats/hershey/

// Requires TOUL: https://www.thingiverse.com/thing:1237203

use <TOUL.scad>
use <handyfunctions.scad>

include <hershey_western.scad>
include <hershey_japanese.scad>
include <hershey_fontsets.scad>
use <hershey_parsetools.scad>


// Here are limited ASCII Roman letter specimens in various styles:
*generate_specimen(roman_plain);
*generate_specimen(roman_simplex);
*generate_specimen(roman_duplex);
*generate_specimen(roman_triplex);
*generate_specimen(roman_complex);
*generate_specimen(roman_complex_small);
*generate_specimen(script_complex);
*generate_specimen(script_simplex);
*generate_specimen(gothic_english);
*generate_specimen(gothic_german);
*generate_specimen(gothic_italian);
*generate_specimen(italic_complex);
*generate_specimen(italic_complex_small);
*generate_specimen(italic_triplex);

// Greek fontsets for Unicode 0x391-0x3A9 and 0x3B1-0x3C9
*generate_specimen(greek_simplex);
*generate_specimen(greek_simplex_small);
*generate_specimen(greek_complex);
*generate_specimen(greek_complex_small);

// Cyrillic fontsets for Unicode 0x410-0x44F
*generate_specimen(cyrillic_complex);

module generate_specimen(fontset, thickness=0.5) {
  n = len(fontset);
  for (i = [0:16:n-1]) {
    dy(-40*i/16-20) recursiveparse([for (j=[i:i+15]) fontset[j]], thickness);
  }
}

// Generate a whole sheet of western and Japanese characters
n = len(western);
for (i = [0:16:n-1]) {
  dy(-40*i/16-20) recursiveparse([for (j=[i:i+15]) western[j]]);
  dy(-40*i/16-20) text(str(i), size=15, halign="right");
}
n2 = len(japanese);
for (i = [0:16:n2-1]) {
  dx(500) dy(-40*i/16-20) recursiveparse([for (j=[i:i+15]) japanese[j]]);
}