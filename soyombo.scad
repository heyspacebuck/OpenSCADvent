// OpenSCADvent Soyombo
// Space Buck, December 2020
// Works cited: 
// https://www.crwflags.com/Fotw/flags/mn.html
// https://web.archive.org/web/20120416040800/http://www.president.mn/mongolian/node/1958

use <handyfunctions.scad>
$fn=64;

// Some example ways to use this scad file:
*soyombo();
*rotate_extrude(angle=180) dx(9) soyombo();
flag();


module soyombo() {
  // The two vertical rectangles (▮) can be interpreted as the walls of a fort. They represent unity and strength, relating to a Mongolian proverb: "The friendship of two is stronger than stone walls."
  square([5, 24]);
  dx(17) square([5, 24]);
  
  // The two triangles (▼) allude to the point of an arrow or spear. They point downward to announce the defeat of interior and exterior enemies.
  dx(11) polygon([[0, 0], [-5, 3], [5, 3]]);
  dx(11) dy(21) polygon([[0, 0], [-5, 3], [5, 3]]);
  
  // The two horizontal rectangles (▬) give stability to the round shape. The rectangular shape represents the honesty and justice of the people of Mongolia, whether they stand at the top or at the bottom of society.
  dx(6) dy(4) square([10, 2]);
  dx(6) dy(18) square([10, 2]);
  
  // The Taijitu symbol (☯) illustrates the mutual complement of man and woman. In socialist times till this day, it was alternatively interpreted as two fishes, symbolizing vigilance, because fish never close their eyes.
  dx(11) dy(12) taijitu();
  
  // Sun (●) and moon symbolise that the Mongolian nation will exist for eternity as the eternal blue sky.
  difference() {
    dx(11) dy(30.5) circle(5.5);
    dx(11) dy(33) circle(6);
  }
  dx(11) dy(32) circle(4);
  
  // Fire is a general symbol of eternal growth, wealth, and success. The three tongues of the flame represent the past, present, and future.
  dx(11) dy(39.5) fire();
}

module taijitu() {
  difference() {
    circle(r=5);
    dy(-2.65) circle(1);
    dy(2.65) circle(1);
    dy(2.65) difference() {
      circle(2.95);
      circle(2.35);
      projection() mx() yz();
    }
    dy(-2.65) difference() {
      circle(2.95);
      circle(2.35);
      projection() yz();
    }
  }
}

module fire() {
  difference() {
    circle(2.5);
    dy(0.5) dx(-1) circle(0.5);
    dy(0.5) dx(1) circle(0.5);
    projection() dy(0.5) xz();
  }
  flame1();
  flame2();
  mx() flame1();
}

module flame1() {
  step = 0.01;
  
  // side 1: initial point is [-2.5*cos(atan(.2)), 0.5], final point is [-1, 3]
  function side1x(t) = -2.5*cos(atan(.2)) + (-1+2.5*cos(atan(.2)))*t + 0.2*(sin(360*1*t));
  function side1y(t) = 0.5+2.5*t;
  side1 = [for (t=[0:step:1]) [side1x(t), side1y(t)]];
  
  // side 2: initial point is [-1, 3], final point is [-1.5, 0.5]
  function side2x(t) = -1 - 0.5*t - .2*sin(360*t);
  function side2y(t) = 3 - 2.5*t;
  side2 = [for (t=[0:step:1]) [side2x(t),side2y(t)]];
  
//  polygon([[-2.5*cos(atan(.2)), 0.5], [-1, 3], [-1.5, 0.5]]);
  polygon([for (pt = side1) pt, for (pt = side2) pt]);
}

module flame2() {
  step = 0.01;
  
  // side 1: initial point is [-0.5, 0.5], final point is [0.4, 5.5]
  function side1x(t) = -0.5 + 0.9*t + 0.15*sin(360*2*t);
  function side1y(t) = 0.5 + 5*t;
  side1 = [for (t=[0:step:1]) [side1x(t), side1y(t)]];
  
  // side 2: initial point is [0.4, 5.5], final point is [0.5, 0.5]
  function side2x(t) = 0.4 + 0.1*t + 0.1*(1-cos(360*2*t));
  function side2y(t) = 5.5 - 5*t;
  side2 = [for (t=[0:step:1]) [side2x(t), side2y(t)]];
  
  polygon([for (pt = side1) pt, for (pt = side2) pt]);
}

module flag() {
  color("#FFD900") dz(1) dy(9) dx(9) linear_extrude(1) soyombo();
  color("#E60019") linear_extrude(1) square([40, 60]);
  color("#0066FF") dx(40) linear_extrude(1) square([40, 60]);
  color("#E60019") dx(80) linear_extrude(1) square([40, 60]);
}