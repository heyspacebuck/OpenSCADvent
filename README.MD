# OpenSCAD Advent (OpenSCADvent)

Let's see how long I can keep this up. Going to post some OpenSCAD gizmos every day until Xmas.

## Day 1: Extremely useful functions

![](img/handyfunctions.png)

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

![](img/hillside.png)

**Day 1 Update:** I added three more methods to <handyfunctions.scad>: xy(), xz(), and yz() to fill a plane. They're very useful for difference() and intersection() operations.

Here is a pleasant hillside surface generated from Perlin noise. It's a good demonstration of the extremely useful modules from day 1. In proper parametric form, you can change the angle of the hillside. This *was* going to be a bit more elaborate, but then I discovered that the `surface()` command *can't* take a matrix as input, it has to take an external file. This seems like an easy feature that OpenSCAD could implement! Anyway, I used the [sample Perlin noise bitmap from Wikipedia](https://en.wikipedia.org/wiki/Perlin_noise#/media/File:Perlin.png) to create a flat surface. Then I provided two slightly different approaches to angle it upward without too much distortion.

Yes, it's a very simple SCADvent today, but it's one that future SCADvents will rely on, so I wanted to get it in early!

## Day 3: Random bivalve

![](img/random_bivalve.png)

Have you ever used the randomness function in OpenSCAD? If not, why not? Here's a nice little demo of `rands()` for you. The clam opens its shell to a random angle, and if you're lucky, there will be a chunky pearl inside!

I took the original clam .stl, and hollowed and split it, using Meshlab and Blender. Theoretically it *is* possible to do all of it from within OpenSCAD. However, hollowing a model in OpenSCAD is...unwise. You must subtract the original model from a large cube, take the minkowski sum of that with a sphere, and then intersect *that* with the original model. And minkowski() on an organic shape like this would take FOREVER. So I did it in Meshlab and Blender.

## Day 4: Make your own monument

![](img/monument.png)

This is your chance to design the "Monument to Whatever Unicode Glyphs You Want"! It uses `handyfunctions.scad` from Day 1, `hillside.scad` from Day 2, and the `random()` function we talked about yesterday. Take a set of glyphs (of your choosing) and watch them emerge from the earth!

Okay, a little backstory. When someone first told me about the Monument to the Armenian Alphabet, he took some poetic license. He described the stone glyphs as if they were partly sunk into the earth at weird angles, as if these massive letters had been sown across the land by some incredible, powerful force. I think that is an AMAZING and very reverent way to design a monument to a writing system. And, therefore, [the actual monument](https://www.atlasobscura.com/places/armenian-alphabet-monument) came as a little bit of a letdown! I can understand why the letters are elevated on plinths, but the haphazard-scattering idea has stuck with me for years and years. Finally, it's here.

![](img/monument2.png)

## Day 5: 2D and 3D spiral modules

![](img/spiralspiral.png)

Here's a library for generating semicircular spirals! The first module, `spiral()`, generates a 2D polygon. The second module, `spiral_extrude()`, works like `linear_extrude()` or `rotate_extrude()`—specify any 2D shape and it will get extruded into a spiral. Lots of fun to be had!

## Day 6: An upsetting ḥanukkiyah (menorah) for an upsetting year

![](img/hanukkiyah.png)

We've all been noticing it: time doesn't seem to work the way it used to. It still feels like March, somehow, and some weeks go by in the blink of an eye. It's confusing and upsetting. How can we commemorate an 8-night holiday when time feels so nonlinear?

Please enjoy these randomly-generated ḥanukkiyot specifically made for this weird year 5781.

Notice the additional file `torus.scad`! This is another very useful library file that you will need to generate your own upsetting ḥanukkiyot.

## Day 7: Viļaka cookie cutters

![](img/vilaka.png)

I don't know much about Latvia but I *do* know that the [coat of arms of the town of Viļaka](https://en.wikipedia.org/wiki/Vi%C4%BCaka) is really really good. A smiley hedgehog and some flowers, what a great concept for a coat of arms. There's an okay-quality SVG version of the seal, so I extracted some of the paths from that and turned them into cookie cutters! Have some hedgehog and flower cookies!

## Day 8: Gävle Goat

![](img/gavlegoat.png)

It's a yule goat! What makes it specifically the Gävle Goat, you ask? Well......

![](img/ohno.gif)

## Day 9: Meissner Tetrahedra (and vec3 math tools)

![](img/meissners.png)

There have been OpenSCAD Meissner tetrahedra before, but I think this is the first that does all the calculations within OpenSCAD (as opposed to dropping them into the file as magic numbers). The only info the file starts with is the dihedral angle of a regular tetrahedron. Then, give it one vertex of your desired solid, and OpenSCAD does the rest!

This also introduces `vec3math.scad`. This lets me transform single points (vectors of length 3) similarly to how `handyfunctions.scad` lets me transform objects.

## Day 10: Cylindrical projection of 2D objects

![](img/wrapcylinder.png)

This took a million-and-one hours to render, and I'm not even that happy with the results.

## Day 11: the famous Mathematica butt

![](img/butt.png)

As we all know, the greatest Stack Exchange page is this Mathematica one, [*How do I draw a pair of buttocks?*](https://mathematica.stackexchange.com/questions/66538/how-do-i-draw-a-pair-of-buttocks) I have lovingly ported the top answer to OpenSCAD. This one requires [scad-utils](https://github.com/openscad/scad-utils) and [skin.scad](https://github.com/openscad/list-comprehension-demos) to work, but trust me, it's worth it.

## Day 12: Hanunó'o love poem

![](img/hanunoo.png)

> So, you will be going now,
> Starting on a journey far!
> Your eyes will enjoy the trip
> Many things you will behold.
> But I, who will stay behind,
> Here within this four-walled room,
> What thoughts could I entertain?
> Just looking up at the roof,
> Just looking down at the floor.

Hanunó'o (a.k.a. Hanunoo, a.k.a. Hanunuo) is a language and a [writing system](https://en.wikipedia.org/wiki/Hanunuo_script) from the island of Mindoro, in the Philippines. As I understand it, the script is traditionally used to write love poems on bamboo. I got this poem from [Endangered Alphabets dot net](https://www.endangeredalphabets.net/alphabets/hanunuo/).

This requires a Hanunó'o Unicode typeface. For some reason, OpenSCAD won't recognize the [Noto Sans Hanunoo font](https://www.google.com/get/noto/#sans-hano) in my system fonts folder, so I had to copy the .ttf file into my OpenSCADvent folder and include it explicitly.

## Day 13: The flag of Nepal

![](img/nepal.png)

The flag of Nepal is notable for many reasons; among them, the geometric rules for its construction—with a compass and straightedge—are [enshrined in the national constitution](http://lawcommission.gov.np/en/archives/821). [Numberphile did a video construction](https://www.youtube.com/watch?v=f2Gne3UHKHs) that is worth checking out.

In OpenSCAD, I've followed the instructions to the best of my ability. On lines 54 and 55, you can specify whatever points you want for A and B (assuming they're on the XY plane) and OpenSCAD will automatically compute the rest of the flag for you. There's some ambiguity about the rays of the moon, which I [dove into on Twitter last night](https://twitter.com/heyspacebuck/status/1337857007362183168), if you're interested.

Like several of my previous models, handyfunctions.scad (from day 1) and vec3math.scad (from day 9) are required to build this model. I've attached them to this Thing.

![](img/nepal2.png)