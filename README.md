# Ruby2D Camera Demo

`ruby run.rb` to run the demo

---

Controls:

WASD to move character  
IJKL to switch camera into manual mode, and to move it around  
F to switch camera back into follow mode  
Q/E to zoom change the zoom  
R to reset the zoom  

---

I wanted to make a proof of concept to see how feasible it is to implement a camera system in Ruby2D. Turns out it is very feasible :D  

How it works:

A single `Camera` class exists which keeps track of most objects that exists. Whenever you want the camera to move it simply move the entire game world.  
If you want to use this little demo in your own projects feel free to do so! All you need is the camera.rb file and then just `require` or `require_relative` it into your project.  
See the code as an example for how it is used.

Credit is appreciated but not required :)


