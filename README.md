# Ruby2D Camera Demo

`ruby run.rb` to run the demo.

## Controls:

WASD to move character  
Q/E to rotate camera  
Hold R to reset the rotation  
Space to enter doors

## How it works:

A single `Camera` module exists which keeps track of objects that you add to it. When you add an object to the camera it creates a wrapper for the object and 'monkey patches' it onto the object to work with the camera.

Feel free to use any part of this code in your own projects, no credit required(but is appreciated [^; )

## How to use the camera in your own code:

Copy the `lib/camera/` directory into your ruby project and then in your code simply ```require_relative 'camera/camera'``` at the top. In your `Update do` loop you must add ```Camera.redraw``` at the bottom(this is so that the camera applies any changes you tell it to do). Your camera is now ready to use!

To add an object to the camera simply do ```Camera << @your_object``` and the camera will do its magic on your object. Only the various shape/image/text/line/sprite/etc. from Ruby2D are supported.  
Whenever an object is wrapped by the camera it gets `x` and `y` methods if it does not already have them which you can use to move the object around in the camera. The text object also gets a `center` method which you can set to true if you wish the origin of text to be its center. Otherwise the origin of all objects is the top left corner. Other then these methods mentioned, object and their methods behave as expected within the context of the camera.

When unloading an object, make sure to also remove it from the Camera or else it will attempt to update it when it is Nil. To do this use the following: `Camera.remove(@your_object)`

To manipulate the camera there are 4 variables you can use:

- `Camera.zoom` Default: 1. This is a multiplier for how much you want the camera to be zoomed in(e.g 2 is 2x zoom, 0.5 is 0.5x zoom)
- `Camera.x` and `Camera.y` Default: 0. This are the position of the camera in the "world"
- `Camera.angle` Default: 0. This is the angle of how much the camera is rotated(in degrees). It ranges from 0-359. Giving values outside of this range will automagically convert them to fit within the 0-359 range.

