// OpenSCADvent spiral modules
// By Space Buck, December 2020

include <handyfunctions.scad>




// Some Example uses:

//spiral_extrude(3, 13, 3.1) circle(1);

//spiral(3,13,.5,3);

//spiral_extrude(3, 7, 1.5) spiral(0,1,.1,3.25);




module spiral(innerRadius, outerRadius, thickness, numTurns) {
  // Radial increase per full turn
  dR = (outerRadius - innerRadius)/numTurns;
  
  // Number of full arcs
  numFullArcs = floor(numTurns*2);
  
  // Size of partial final arc
  finalArc = numTurns*2 - numFullArcs;
  
  // For each half-turn, generate a semicircular arc of the specified thickness
  for (i = [1 : 1 : numFullArcs]) {
    initArcRad = innerRadius + (i-1)*dR/2;
    finalArcRad = innerRadius + i*dR/2;
    rz((i-1)*180) {
      dx(-(finalArcRad - initArcRad)/2) {
        difference() {
          circle(r = (finalArcRad + initArcRad)/2 + thickness/2);
          circle(r = (finalArcRad + initArcRad)/2 - thickness/2);
          dx(-finalArcRad) dy(-finalArcRad) square([finalArcRad*2, finalArcRad]);
        }
      }
    }
  }
  
  // If there's a non-integer number of turns, add the final partial arc here
  if (finalArc != 0) {
    initArcRad = innerRadius + numFullArcs*dR/2;
    finalArcRad = innerRadius + (numFullArcs+1)*dR/2;
    rz(numFullArcs*180) {
      dx(-(finalArcRad - initArcRad)/2) {
        difference() {
          circle(r = (finalArcRad + initArcRad)/2 + thickness/2);
          circle(r = (finalArcRad + initArcRad)/2 - thickness/2);
          dx(-finalArcRad) dy(-finalArcRad) square([finalArcRad*2, finalArcRad]);
          rz(180*finalArc) square([finalArcRad, finalArcRad]);
        }
      }
    }
  }
}

module spiral_extrude(innerRadius, outerRadius, numTurns) {
  // Radial increase per full turn:
  dR = (outerRadius - innerRadius)/numTurns;  
  
  // Number of full arcs
  numFullArcs = floor(numTurns*2);

  // Size of partial final arc
  finalArc = numTurns*2 - numFullArcs;
  
  // For each half-turn, generate an offset semicircle
  for (i = [1 : 1 : numFullArcs]) {
    initArcRad = innerRadius + (i-1)*dR/2;
    finalArcRad = innerRadius + i*dR/2;
    rz((i-1)*180) {
      dx(-(finalArcRad - initArcRad)/2) {
        rotate_extrude(angle=180) {
        // Offset children by radius for this particular arc (avg of start/end radii)
        dx((finalArcRad + initArcRad)/2) children();
        }
      } 
    }
  }
  // If there's a non-integer number of turns, add the final partial arc here
  if (finalArc != 0) {
    initArcRad = innerRadius + numFullArcs*dR/2;
    finalArcRad = innerRadius + (numFullArcs+1)*dR/2;
    rz(numFullArcs*180) {
      dx(-(finalArcRad - initArcRad)/2) {
        rotate_extrude(angle = 180*finalArc) {
          dx((finalArcRad + initArcRad)/2)
          children();
        }
      }
    }
  }
}
