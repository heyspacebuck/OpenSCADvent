# OpenSCAD Advent (OpenSCADvent)

Let's see how long I can keep this up. Going to post some OpenSCAD gizmos every day until Xmas.

## Day 1: Extremely useful functions

For day 1 of OpenSCADvent, I'm sharing with you *handyfunctions.scad*. Most of the time, when using translate() and rotate() in OpenSCAD, I'm only translating or rotating over a single axis. So I created these shorthand functions that leave the code shorter, cleaner, and more readable (in my opinion). They really, really help me write OpenSCAD code without disrupting my own train of thought.

To use the handy functions:
- Put this file in the /libraries/ subfolder of the OpenSCAD documents folder
- Put `use <handyfunctions.scad>` or `include <handyfunctions.scad>` at the top of your OpenSCAD design
- To translate along x, y, or z by *n* units: use `dx(n)`, `dy(n)`, `dz(n)`
- To rotate around the x-axis, y-axis, or z-axis by *n* degrees: use `rx(n)`, `ry(n)`, `rz(n)`
- To scale an object by a factor of *n* in x, y, or z: use `sx(n)`, `sy(n)`, `sz(n)`
- To mirror a design via the x-axis, y-axis, or z-axis: use `mx()`, `my()`, `mz()`
- To skew the x-axis along y-axis or z-axis by a ratio *n*: use `skewxy(n)`, `skewxz(n)`
- To skew the y-axis along x-axis or z-axis by a ratio *n*: use `skewyx(n)`, `skewyz(n)`
- To skew the z-axis along x-axis or y-axis by a ratio *n*: use `skewzx(n)`, `skewzy(n)`
- To fill the positive XY plane: use `xy()`
- To fill the positive XZ plane: use `xz()`
- To fill the positive YZ plane: use `yz()`

I've included some simple examples in `handyfunctions_examples.scad`. More elaborate examples can be found in my other things on Thingiverse, or just wait for the coming OpenSCADvent designs, which will be using this library.