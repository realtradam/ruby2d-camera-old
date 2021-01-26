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
  @squares << AnimatedSquare.new(x: (0..1920).to_a.sample,
                                 y: (0..1080).to_a.sample,
                                 size: (10..50).to_a.sample,
                                 color: 'random')
  Camera << @squares.last
end

# An example of static elements on the screen that
# do not follow the camera movement
Rectangle.new(
  width: 350,
  height: 70,
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
    @x_move -= @speed
  end
  if event.key == 'd'
    @x_move += @speed
  end
  if event.key == 'w'
    @y_move -= @speed
  end
  if event.key == 's'
    @y_move += @speed
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
  if event.key == 'q'
    @zoom_by = 1.05
  end
  if event.key == 'e'
    @zoom_by = 0.95
  end
  if event.key == 'r'
    Camera.zoom_to 1
  end
end
@quad = Quad.new(x1: 0, y1: 0,
                 x2: 20, y2: 0,
                 x3: 20, y3: 20,
                 x4: 0, y4: 20)
Camera << @quad
@frame = 0
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
  @quad.rotate(50 - @quad.x,50 - @quad.y,5)
  @quad.color = 'random' if @frame.zero?
  # Alternating between follow and manual control
  if @is_follow
    Camera.follow @player
  else
    Camera.move_by(@cam_x_move, @cam_y_move)
  end
  @player.rotate(@player.x1, @player.y1, 5)

  # This function will teleport the camera directory to those coordinates
  # It is used by Camera.follow but you can use it yourself too!
  #Camera.move_to(50,50)
  @cam_x_move = 0
  @cam_y_move = 0
  @ui_pos.text = "Camera Position: #{Camera.camera_position[0].round(1)}, #{Camera.camera_position[1].round(1)}"
  @ui_zoom.text = "Zoom: #{Camera.zoom_level.round(3)}"
end

show
