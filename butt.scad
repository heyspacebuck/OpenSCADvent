// OpenSCADvent, the famous Mathematica butt
// Space Buck, December 2020
// Works cited: https://mathematica.stackexchange.com/questions/66538/how-do-i-draw-a-pair-of-buttocks

// In addition to my previous libraries, this one requires scad-utils and list-comprehension-demos, available here:
// https://github.com/openscad/scad-utils
// https://github.com/openscad/list-comprehension-demos

use <skin.scad>

function sq(x) = pow(x, 2);
function sinh(x) = (1 - exp(-2*x))/(2*exp(-x));
function cosh(x) = (1 + exp(-2*x))/(2*exp(-x));
function tanh(x) = sinh(x)/cosh(x);

function box(x, x1, x2, a, b) = tanh(a*(x - x1)) + tanh(-b*(x-x2));
function ex(z, z0, s) = exp(-sq(z - z0)/s);

function r(z, t) = 0.4*(1 - 0.4*ex(z, 0.8, 0.15) +
sq(sin(360*t)) + 0.6*ex(z, 0.8, 0.25)*sq(cos(360*t)) + 0.3*cos(360*t))*0.5*(1 + tanh(4*z)) +
(1 - 0.2*ex(z, -1.3, 0.9))*0.5*(1 + tanh(-4*z))*(0.5*(1 + sq(sin(360*t)) + 
0.3*cos(360*t))*(pow(abs(sin(360*t)),1.3) + 0.08*(1 + tanh(4*z)))) + 
0.13*box(cos(180*t), -0.45, 0.45, 5, 5)*box(z, -0.5, 0.2, 4, 2) -
0.1*box(cos(180*t), -0.008, 0.008, 30, 30)*box(z, -0.4, 0.25, 8, 6) -
0.05*pow(sin(180*t),16)*box(z, -0.55, -0.35, 8, 18);

function buttSurf(z, t) =
  let (x = 0.1*exp(-sq(z-0.8)/0.6) - 0.18*exp(-sq(z-0.1)/0.4) + r(z, t)*cos(360*t))
  let (y = r(z, t)*sin(360*t))
  [x, y, z];

function buttSlice(z) = [
  for (t = [0:.01:1]) buttSurf(z, t)
];

skin([for (z = [-1.5:.05:1.5]) buttSlice(z)]);