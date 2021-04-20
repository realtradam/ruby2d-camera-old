# Ruby2D Camera Demo

`ruby run.rb` to run the demo

---

Controls:

WASD to move character  
IJKL to move camera
Q/E to rotate camera
R to reset the rotation

---

I wanted to make a proof of concept to see how feasible it is to implement a camera system in Ruby2D. Turns out it is very feasible :D  

How it works:

A single `Camera` module exists which keeps track of objects that you add to it. When you add an object to the camera (currently only triangles) it creates a wrapper for the object and modifys it to work with the camera.

If you want to use this little demo in your own projects feel free to do so! All you need is the camera.rb file and then just `require` or `require_relative` it into your project.  
See the code as an example for how it is used.

Credit is appreciated but not required :)


