# frozen_string_literal: true

require 'ruby2d'
require_relative 'camera'

#set width: 700, height: 300

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
@player = Triangle.new(x1: 0,
                       y1: 0,
                       x2: 0,
                       y2: 0 + 25,
                       x3: 0 + 25,
                       y3: 0 + 25,
                       size: (10..50).to_a.sample,
                       color: 'random')
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
  if event.key == 't'
    @debug3 += 2
  end
  if event.key == 'g'
    @debug3 -= 2
  end
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
  if event.key == 'f'
    @debug1 += 2
    #@is_follow = true
  end
  if event.key == 'h'
    @debug1 -= 2
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
    Camera.angle += 2
  end
  if event.key == 'e'
    Camera.angle -= 2
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
end

show
