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

## Day 2: A pleasant hillside

**Day 1 Update:** I added three more methods to <handyfunctions.scad>: xy(), xz(), and yz() to fill a plane. They're very useful for difference() and intersection() operations.

Here is a pleasant hillside surface generated from Perlin noise. It's a good demonstration of the extremely useful modules from day 1. In proper parametric form, you can change the angle of the hillside. This *was* going to be a bit more elaborate, but then I discovered that the `surface()` command *can't* take a matrix as input, it has to take an external file. This seems like an easy feature that OpenSCAD could implement! Anyway, I used the [sample Perlin noise bitmap from Wikipedia](https://en.wikipedia.org/wiki/Perlin_noise#/media/File:Perlin.png) to create a flat surface. Then I provided two slightly different approaches to angle it upward without too much distortion.

Yes, it's a very simple SCADvent today, but it's one that future SCADvents will rely on, so I wanted to get it in early!

## Day 3: Random bivalve

Have you ever used the randomness function in OpenSCAD? If not, why not? Here's a nice little demo of `rands()` for you. The clam opens its shell to a random angle, and if you're lucky, there will be a chunky pearl inside!

I took the original clam .stl, and hollowed and split it, using Meshlab and Blender. Theoretically it *is* possible to do all of it from within OpenSCAD. However, hollowing a model in OpenSCAD is...unwise. You must subtract the original model from a large cube, take the minkowski sum of that with a sphere, and then intersect *that* with the original model. And minkowski() on an organic shape like this would take FOREVER. So I did it in Meshlab and Blender.