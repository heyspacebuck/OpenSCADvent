// OpenSCADvent Handy functions examples
// Space Buck, December 2020

// This is the line that makes the magic happen:
include <handyfunctions.scad>;

// To translate a shape along x, y, or z, use dx(n), dy(n), dz(n)
color("red") dx(10) cube(10);

// To rotate a shape around the x-axis, y-axis, or z-axis, use rx(n), ry(n), rz(n)
color("green") rz(135) cube(10);

// To scale a shape along x, y, or z, use sx(n), sy(n), sz(n)
color("pink") sz(-2) cube(10);

// To mirror a shape across the x-axis, y-axis, or z-axis, use mx(), my(), mz()
color("blue") my() cube(10);

// To skew a shape, use skewxy(n), skewxz(n), skewyx(n), skewyz(n), skewzx(n), skewzy(n)
color("purple") skewyz(.5) cube(10) ;