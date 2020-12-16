// Hershey code parsing tools
use <TOUL.scad>
use <handyfunctions.scad>

// Parse the strokes--not the spacing, not the vector counts or the other stuff
module hersheystroke(string, thickness=.5) {
  for (i = [0:2:len(string)-3]) {
    x0 = ord(string[i]) - ord("R");
    y0 = -1*(ord(string[i+1]) - ord("R"));
    x1 = ord(string[i+2]) - ord("R");
    y1 = -1*(ord(string[i+3]) - ord("R"));
    
    // If x==-50 and y==0, lift pen
    if ((x0 != -50 || y0 != 0) && (x1 != -50 || y1 != 0)) {
      hull() {
        translate([x0, y0, 0]) circle(thickness);
        translate([x1, y1, 0]) circle(thickness);
      }
    }
  }
}

module hersheyparse(line, thickness=.5) {
  if (!is_undef(line)) {
    n = len(line);
    // First 5 columns are the Hershey index
    hIndex = getIndex(line);
    // Next 3 columns are the number of vertices
    vertices = getVertices(line);
    // Left bound, right bound are the next two columns (not used here)
//    bounds = getBounds(line);
    // Remainder of line is the set of strokes
    strokes = substr(line, 10, (vertices-1)*2);
    hersheystroke(strokes, thickness);
  }
}

function getBounds(string) = [ord(string[8]) - ord("R"), ord(string[9]) - ord("R")];

function getIndex(x) = 
  let (y4 = ord(x[0]) == 32 ? 0 : ord(x[0])-48)
  let (y3 = ord(x[1]) == 32 ? 0 : ord(x[1])-48)
  let (y2 = ord(x[2]) == 32 ? 0 : ord(x[2])-48)
  let (y1 = ord(x[3]) == 32 ? 0 : ord(x[3])-48)
  let (y0 = ord(x[4]) == 32 ? 0 : ord(x[4])-48)
  1e0*y0 + 1e1*y1 + 1e2*y2 + 1e3*y3 + 1e4*y4;
  
function getVertices(x) = 
  let (y2 = ord(x[5]) == 32 ? 0 : ord(x[5])-48)
  let (y1 = ord(x[6]) == 32 ? 0 : ord(x[6])-48)
  let (y0 = ord(x[7]) == 32 ? 0 : ord(x[7])-48)
  1e0*y0 + 1e1*y1 + 1e2*y2;

module recursiveparse(lines, thickness=0.5) {
  n = len(lines);
  if (n > 0 && !is_undef(lines[0])) {
    bounds = getBounds(lines[0]);
    dx(-bounds[0]) hersheyparse(lines[0], thickness);
    if (n > 1) {
      dx(bounds[1]-bounds[0]) recursiveparse([for (l=[1:n-1]) lines[l]], thickness);
    }
  }
}