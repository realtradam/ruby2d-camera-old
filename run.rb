# frozen_string_literal: true

require 'ruby2d'
require_relative 'lib/camera/camera'

#set width: 700, height: 300

Window.set(icon: "./assets/blobdanceextract/blob#{(1...20).to_a.sample}.png")

# Use this to add a few extra methods to an Image
module SizableImage
  def size
    width
  end

  def size=(size)
    self.height *= (size / width)
    self.width *= (size / width)
  end
end


# There is 2 ways you can add objects to be known and controlled by the camera, both do the same thing

#@square = Square.new(
#  x: 100, y: 100,
#  size: 125,
#  color: 'random'
#)

#Camera << @square

25.times do
  tempx = (0..1920).to_a.sample
  tempy = (0..1080).to_a.sample
  tempsize = (25..100).to_a.sample
  Camera << Triangle.new(x1: tempx,
                         y1: tempy,
                         x2: tempx,
                         y2: tempy + tempsize,
                         x3: tempx + tempsize,
                         y3: tempy + tempsize,
                         size: (10..50).to_a.sample,
                         color: 'random')
end
@background = Image.new(
  'assets/background.png',
  x: 0, y: 0,
  width: (1920 * 0.25), height: (1080 * 0.25),
  z: -1
)
Camera << @background
@line = Line.new(x1: -40,
                 y1: -50,
                 x2: 60,
                 y2: 70,
                 width: 35,
                 color: 'random')
Camera << @line
=begin
@player = Quad.new(x1: 0,
                   y1: 0,
                   x2: 0,
                   y2: 0 + 25,
                   x3: 0 + 25,
                   y3: 0 + 25,
                   x4: 0 + 25,
                   y4: 0,
                   size: (10..50).to_a.sample,
                   color: 'blue')
=end
@player = Square.new(x: 0,
                     y: 0,
                     size: 100,
                     color: 'random')
@sprite = Sprite.new('./assets/sprites/blob.png',
                     x: 300,
                     y: 300,
                     width: 100,
                     height: 100,
                     clip_width: 128,
                     loop: true,
                     time: 17)
Camera << @sprite
@sprite.play
Camera << @player
Camera << @player
Rectangle.new(
  width: 350,
  height: 135,
  color: 'navy'
)
@ui_pos_cam = Text.new(
  'pos: 0,0',
  x: 10,
  y: 10,
  color: 'teal'
)
@ui_pos_ply = Text.new(
  'pos: 0,0',
  x: 10,
  y: 40,
  color: 'teal'
)
@ui_zoom = Text.new(
  'zoom: 0',
  x: 10,
  y: 70,
  color: 'lime'
)
@ui_rotation = Text.new(
  'rotation: 0',
  x: 10,
  y: 100,
  color: 'lime'
)
Rectangle.new(
  x: (Window.width - 120),
  width: 120,
  height: 45,
  color: 'navy'
)
@ui_fps = Text.new(
  'fps: 60.00',
  x: (Window.width - 110),
  y: 10,
  color: 'teal'
)



# How fast the player can move
@speed = 10

# Initializing
@x_move = 0
@y_move = 0
@cam_x_move = 0
@cam_y_move = 0
@is_follow = true
@zoom_by = 1
@debug1 = 0
@debug2 = 0
@debug4 = 0
@debug3 = 0

on :key do |event|
  if event.key == 'a'
    @y_move += 0
    @x_move += -@speed
  end
  if event.key == 'd'
    @y_move += 0
    @x_move += @speed
  end
  if event.key == 'w'
    @y_move += -@speed
    @x_move += 0
  end
  if event.key == 's'
    @y_move += @speed
    @x_move += 0
  end
  if event.key == 'j'
    @cam_x_move -= @speed
    @is_follow = false
  end
  if event.key == 'l'
    @cam_x_move += @speed
    @is_follow = false
  end
  if event.key == 'i'
    @cam_y_move -= @speed
    @is_follow = false
  end
  if event.key == 'k'
    @cam_y_move += @speed
    @is_follow = false
  end
end
on :key_down do |event|
  if event.key == 'f'
    Camera.debug_x += 2
    @player.size -= 5
  end
  if event.key == 'h'
    Camera.debug_x -= 2
    @player.size += 5
  end
  if event.key == 't'
    Camera.debug_y += 2
    @player.height += 5
  end
  if event.key == 'g'
    Camera.debug_y -= 2
    @player.height -= 5
  end
end

on :key do |event|
  if event.key == 'z'
    @zoom_by = 1.015
  end
  if event.key == 'x'
    @zoom_by = 0.985
  end
  if event.key == 'c'
    #Camera.zoom_to 1
  end
  if event.key == 'm'
    #Camera.move_to(-10,-10)
  end

  if event.key == 'q'
    Camera.angle -= 2
  end
  if event.key == 'e'
    Camera.angle += 2
  end
  if event.key == 'r'
    Camera.angle = 0.0
    Camera.zoom = 1.0
  end
end
update do
  @player.x += @x_move
  @player.y += @y_move
  @x_move = 0
  @y_move = 0
  Camera.zoom *= @zoom_by

  if @is_follow
    Camera.x = @player.x
    Camera.y = @player.y
  else
    angle = Camera.angle * (Math::PI / 180)
    Camera.x += (@cam_x_move * Math.cos(-angle)) - (@cam_y_move * Math.sin(-angle))
    Camera.y += (@cam_x_move * Math.sin(-angle)) + (@cam_y_move * Math.cos(-angle))
  end
  @cam_x_move = 0
  @cam_y_move = 0
  @zoom_by = 1
  @ui_pos_cam.text = "Camera Position: #{Camera.x.round(1)}, #{Camera.y.round(1)}"
  @ui_pos_ply.text = "Player Position: #{@player.x.round(1)}, #{@player.y.round(1)}"
  @ui_zoom.text = "Zoom: #{Camera.zoom.round(3)}"
  @ui_fps.text = "FPS: #{Window.fps.round(2)}"
  @ui_rotation.text = "Angle: #{Camera.angle}"

  Camera.update
end
show
