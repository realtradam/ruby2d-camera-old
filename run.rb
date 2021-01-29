# frozen_string_literal: true

require 'ruby2d'
require_relative 'camera'
require_relative 'animator'

@background = Image.new('assets/background.png')
#@player =  Image.new('assets/player.png')
@player = Quad.new(x1: 0, y1: 0,
                   x2: 20, y2: 0,
                   x3: 20, y3: 20,
                   x4: 0, y4: 20)
@squares = []

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

@background.extend SizableImage
#@player.extend SizableImage

# There is 2 ways you can add objects to be known and controlled by the camera, both do the same thing
Camera << @background
Camera.add @player

# This controls how slowly the camera will follow an object
# Set to 1 to not have any elasticity
# it is not used by the .move_to or .move_by
Camera.elasticity = 10

# If you want to use a camera, you need all elements in the world to be known to it
# Exeptions would be things such as UI elements where you want them statically placed on the screen
25.times do
  tempx = (0..1920).to_a.sample
  tempy = (0..1080).to_a.sample
  tempsize = (25..100).to_a.sample
  Camera << Quad.new(x1: tempx,
                     y1: tempy,
                     x2: tempx,
                     y2: tempy + tempsize,
                     x3: tempx + tempsize,
                     y3: tempy + tempsize,
                     x4: tempx + tempsize,
                     y4: tempy,
                     size: (10..50).to_a.sample,
                     color: 'random')
end
#25.times do
#  @squares << AnimatedSquare.new(x: (0..1920).to_a.sample,
#                                 y: (0..1080).to_a.sample,
#                                 size: (10..50).to_a.sample,
#                                 color: 'random')
#  Camera << @squares.last
#end

# An example of static elements on the screen that
# do not follow the camera movement
Rectangle.new(
  width: 350,
  height: 105,
  color: 'navy'
)
@ui_pos = Text.new(
  'pos: 0,0',
  x: 10,
  y: 10,
  color: 'teal'
)
@ui_zoom = Text.new(
  'zoom: 0',
  x: 10,
  y: 40,
  color: 'lime'
)
@ui_rotation = Text.new(
  'rotation: 0',
  x: 10,
  y: 70,
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

on :key do |event|
  if event.key == 'a'
    @y_move += Math.sin(Math::PI * (180 + @player.rotation_degrees) / 180) * @speed
    @x_move += Math.cos(Math::PI * (180 + @player.rotation_degrees) / 180) * @speed
  end
  if event.key == 'd'
    @y_move += Math.sin(Math::PI * @player.rotation_degrees / 180) * @speed
    @x_move += Math.cos(Math::PI * @player.rotation_degrees / 180) * @speed
  end
  if event.key == 'w'
    @y_move += Math.sin(Math::PI * (-90 + @player.rotation_degrees) / 180) * @speed
    @x_move += Math.cos(Math::PI * (-90 + @player.rotation_degrees) / 180) * @speed
  end
  if event.key == 's'
    @y_move += Math.sin(Math::PI * (90 + @player.rotation_degrees) / 180) * @speed
    @x_move += Math.cos(Math::PI * (90 + @player.rotation_degrees) / 180) * @speed
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
    @is_follow = true
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
    Camera.zoom_to 1
  end
  if event.key == 'm'
    Camera.move_to(-10,-10)
  end

  if event.key == 'q'
    temp_cam = Camera.camera_position
    Camera.rotate_by(-1)
    Camera.move_to(@player.lazy_center[0] - (Window.width / 2),
                   @player.lazy_center[1] - (Window.height / 2))
  end
  if event.key == 'e'
    Camera.rotate_by(1)
    Camera.move_to(@player.lazy_center[0] - (Window.width / 2),
                   @player.lazy_center[1] - (Window.height / 2))
  end
  if event.key == 'r'
    unless Camera.rotation_degrees.zero?
      Camera.rotate_by(-Camera.rotation_degrees)
      Camera.move_to(@player.lazy_center[0] - (Window.width / 2),
                     @player.lazy_center[1] - (Window.height / 2))
    end
  end
end
@quad = Quad.new(x1: 0, y1: 0,
                 x2: 20, y2: 0,
                 x3: 20, y3: 20,
                 x4: 0, y4: 20)
Camera << @quad
@frame = 0
  @player.rotate_relative(-@player.x,
                          -@player.y,
                          -12)
update do
  @frame += 1
  @frame %= 60
  @player.x += @x_move
  @player.y += @y_move
  @x_move = 0
  @y_move = 0

  if @zoom_by != 1
    Camera.zoom_by @zoom_by
    @zoom_by = 1
  end
  # Need to use the cameras position as an offset to keep the shapes range of movement working
  # Need to make the zoom also give an offset
  @squares.each do |square|
    square.update(Camera.camera_position, Camera.zoom_level)
  end
  @quad.rotate_relative(50 - @quad.x,50 - @quad.y,1)
  @quad.color = 'random' if @frame.zero?
  #puts @quad.rotation_degrees
  # Alternating between follow and manual control
  if @is_follow
    Camera.follow @player
  else
    Camera.move_by(@cam_x_move, @cam_y_move)
  end
  puts @player.x1_debug
  #Camera.rotate_by(2)
  #puts Math.cos(Math::PI * @player.rotation_degrees.to_f / 180)
  #@player.rotate_relative(Math.cos(Math::PI * (@player.rotation_degrees + 1 * 180 / 4) / 180) * (10 * 1.41421356237),
  #                        Math.cos(Math::PI * (@player.rotation_degrees - 1 * 180 / 4) / 180) * (10 * 1.41421356237),
  #                        2)
  # This function will teleport the camera directory to those coordinates
  # It is used by Camera.follow but you can use it yourself too!
  #Camera.move_to(50,50)
  @cam_x_move = 0
  @cam_y_move = 0
  @ui_pos.text = "Camera Position: #{Camera.camera_position[0].round(1)}, #{Camera.camera_position[1].round(1)}"
  @ui_zoom.text = "Zoom: #{Camera.zoom_level.round(3)}"
  @ui_fps.text = "FPS: #{Window.fps.round(2)}"
  @ui_rotation.text = "Angle: #{Camera.rotation_degrees}"
end

show
