// OpenSCADvent flag of Nepal
// Space Buck, December 2020

use <handyfunctions.scad>
use <vec3math.scad>


$fn=32;

// A function to find the intersection of two line segments (assume line segments lie on the xy plane and do intersect)
function intersect(p0, p1, q0, q1) =
  let (r = p1 - p0)
  let (s = q1 - q0)
  let (t = norm(cross(q0-p0, s)) / norm(cross(s, r)))
  p0 + t*r;

// A function to project a point onto a line segment (assume point and line segment lie on xy plane)
function project(p, q0, q1) = 
  let (orthog = rz(q1-q0, 90))
  intersect(p, p+orthog, q0, q1);

// Square function
function sq(x) = pow(x, 2);

// A function to find the two points where a line segment intersects a circle (assume line segment and circle lie on XY plane, and that line segment creates a chord on the circle)
function chord(p, r, q0, q1) =
  let (s = q1 - q0)
  let (a = sq(s.x) + sq(s.y))
  let (b = 2*q0.x*s.x + 2*q0.y*s.y - 2*p.x*s.x - 2*p.y*s.y)
  let (c = sq(p.x) - 2*p.x*q0.x + sq(q0.x) + sq(p.y) - 2*p.y*q0.y + sq(q0.y) - sq(r))
  let (t = (-b + sqrt(sq(b) - 4*a*c))/(2*a))
  let (u = (-b - sqrt(sq(b) - 4*a*c))/(2*a))
  [q0 + t*s, q0 + u*s];

// A function to find the two points where two circles intersect (assume circles lie on XY plane and have two intersections)
function twoCircles(p0, r0, p1, r1) =
  let (slope = -(p0.x - p1.x)/(p0.y - p1.y))
  let (int = (-(sq(r0) - sq(r1)) + (sq(p0.x) - sq(p1.x)) + (sq(p0.y) - sq(p1.y)))/(2*(p0.y - p1.y)))
  let (a = 1 + sq(slope))
  let (b = -2*p0.x - 2*slope*p0.y + 2*slope*int)
  let (c = sq(p0.x) + sq(p0.y) - 2*int*p0.y + sq(int) - sq(r0))
  let (x0 = (-b + sqrt(sq(b) - 4*a*c))/(2*a))
  let (x1 = (-b - sqrt(sq(b) - 4*a*c))/(2*a))
  let (y0 = slope*x0 + int)
  let (y1 = slope*x1 + int)
  [[x0, y0, 0], [x1, y1, 0]];




// Schedule-1 National Flag of Nepal
// (a) Method of making the shape inside the border
// (1) On the lower portion of a crimson cloth draw a line AB of the required length from left to right.
A = [0, 0, 0];
B = [40, 0, 0];
AB = B - A;

// (2) From A draw a line AC perpendicular to AB making AC equal to AB plus one third AB. From AC mark off D making line AD equal to line AB. Join B and D.
AC = rz(AB*4/3, 90);
C = A + AC;
AD = rz(AB, 90);
D = A + AD;
BD = D - B;

// (3) From BD mark off E making BE equal to AB.
E = B + norm(AB)*BD/norm(BD);

// (4) Touching E draw a line FG, starting from the point F on line AC, parallel to AB to the right hand-side. Mark off FG equal to AB.
F = intersect(E-AB, E, A, C);
FG = AB;
G = F + FG;

// (5) Join C and G.
CG = G - C;
module insideBorder() {
  polygon([[A[0], A[1]], [B[0], B[1]], [E[0], E[1]], [G[0], G[1]], [C[0], C[1]]]);
}

// (b) Method of making the moon
// (6) From AB mark off AH making AH equal to one-fourth of line AB and starting from H draw a line HI parallel to line AC touching line CG at point I.
H = A + 1/4*AB;
I = intersect(H, H+AC, C, G);
HI = I - H;

// (7) Bisect CF at J and draw a line JK parallel to AB touching CG at point K.
CF = F - C;
J = C + 1/2*CF;
K = intersect(J, J+AB, C, G);
JK = K - J;

// (8) Let L be the point where lines JK and HI cut one another.
L = intersect(J, K, H, I);

// (9) Join J and G.
JG = G - J;

// (10) Let M be the point where line JG and HI cut one another.
M = intersect(J, G, H, I);

// (11) With centre M and with a distance shortest from M to BD mark off N on the lower portion of line HI.
Nprime = project(M, B, D);
MN = -1*norm(M-Nprime)*HI/norm(HI);
N = M + MN;

// (12) Touching M and starting from O, a point on AC, draw a line from left to right parallel to AB.
O = intersect(A, C, M, M+AB);

// (13) With centre L and radius LN draw a semi-circle on the lower portion and let P and Q be the points where it touches the line OM respectively.
LN = N - L;
module semicircle1() {
  translate(L) circle(r=norm(LN));
}
PandQ = chord(L, norm(LN), M, O);
P = PandQ[0];
Q = PandQ[1];

// (14) With centre M and radius MQ draw a semi-circle on the lower portion touching P and Q.
MQ = Q - M;
module semicircle2() {
  translate(M) circle(r=norm(MQ));
}

// (15) With centre N and radius NM draw an arc touching PNQ at R and S. Join RS. Let T be the point where RS and HI cut one another.
NM = M - N;
RandS = twoCircles(N, norm(NM), L, norm(LN));
R = RandS[0];
S = RandS[1];
T = intersect(R, S, H, I);

// (16) With centre T and radius TS draw a semi-circle on the upper portion of PNQ touching it at two points.
TS = S - T;
module semicircle3() {
  translate(T) circle(r=norm(TS));
}


// (17) With centre T and radius TM draw an arc on the upper portion of PNQ touching at two points.
TM = M - T;
module semicircle4() {
  translate(T) circle(r=norm(TM));
}

// (18) Eight equal and similar triangles of the moon are to be made in the space lying inside the semi-circle of No. (16) and outside the arc of No. (17) of this Schedule.
TR = R - T;
module moonRay() {
  ray0 = norm(TM)*TR/norm(TR);
  ray1 = rz(TR, 180/16);
  ray2 = rz(ray0, 2*180/16);
  polygon([[ray0[0], ray0[1]], [ray1[0], ray1[1]], [ray2[0], ray2[1]]]);
}

module moonRayPrime() {
  ray0 = rz(norm(TM)*TR/norm(TR), -180/14);
  ray1 = TR;
  ray2 = rz(norm(TM)*TR/norm(TR), 180/14);
  polygon([[ray0[0], ray0[1]], [ray1[0], ray1[1]], [ray2[0], ray2[1]]]);
}

module moon() {
  difference() {
    semicircle2();
    semicircle1();
  }
  intersection() {
    semicircle4();
    semicircle1();
  }
  for (i = [0:7]) {
    *translate(T) rz(i*2*180/14) moonRayPrime();
    translate(T) rz(i*2*180/16) moonRay();
  }
  *for (i = [-1:8]) {
    translate(T) rz(i*2*180/16) moonRay();
  }
}

module ambiguousZone() {
  intersection() {
    semicircle1();
    difference() {
      semicircle3();
      semicircle4();
    }
  }
}

// (c) Method of making the sun
// (19) Bisect line AF at U, and draw a line UV parallel to AB line touching line BE at V.
AF = F - A;
U = A + 1/2*AF;
V = intersect(U, U+AB, B, E);

// (20) With centre W, the point where HI and UV cut one another and radius MN draw a circle.
W = intersect(H, I, U, V);
module sun1() {
  translate(W) circle(r = norm(MN));
}

// (21) With centre W and radius LN draw a circle.
module sun2() {
  translate(W) circle(r = norm(LN));
}

// (22) Twelve equal and similar triangles of the sun are to be made in the space enclosed by the circles of No. (20) and of No. (21) with the two apexes of two triangles touching line HI.
module sunRay() {
  // Note: I use 179.9 degrees instead of 180 degrees here to avoid a nonmanifold issue when rendering
  ray0 = norm(LN)*HI/norm(HI);
  ray1 = rz(norm(MN)*HI/norm(HI), -179.9/12);
  ray2 = rz(norm(MN)*HI/norm(HI), 179.9/12);
  polygon([[ray0[0], ray0[1]], [ray1[0], ray1[1]], [ray2[0], ray2[1]]]);
}
module sun() {
  union() {
    sun1();
    for (i = [0:11]) {
      translate(W) rz(i*360/12) sunRay();
    }
  }
}

// (d) Method of making the border
// (23) The width of the border will be equal to the width TN. This will be of deep blue colour and will be provided on all the side of the flag. However, on the five angles of the flag the external angles will be equal to the internal angles.
TN = N - T;
module border() {
  offset(delta=norm(TN)) insideBorder();
}

// (24) The above mentioned border will be provided if the flag is to be used with a rope. On the other hand, if it is to be hoisted on a pole, the hole on the border on the side AC can be extended according to requirements.
//
// Explanation: The lines HI, RS, FE, ED, JG, OQ, JK and UV are imaginary. Similarly, the external and internal circles of the sun and the other arcs except the crescent moon are also imaginary. These are not shown on the flag.

module showPoints() {
  alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W"];
  points = [A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W];

  for (i = [0:22]) {
    point = points[i];
    letter = alphabet[i];
    color("black") translate(point) sphere(.2);
    translate(point) dx(-1.5) linear_extrude(.1) text(letter, size=1);
  }
}

*showPoints();
color("blue") dz(-4) linear_extrude(1) border();
color("red") dz(-3) linear_extrude(1) insideBorder();
color("white") dz(-2) linear_extrude(1) sun();
color("white") dz(-2) linear_extrude(1) moon();