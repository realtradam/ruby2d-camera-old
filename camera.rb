# frozen_string_literal: true

# Simulates a moving camera by manipulating objects it knows
class Camera
  # Is added to quads to manage how they show and modify
  # it should convert or undo the camera modification
  # such that it is as if the camera wasnt there and everything
  # is relative to the origin
  module QuadCameraTracker
    def update(x, y)
      @x1 -= x
      @x2 -= x
      @x3 -= x
      @x4 -= x
      @y1 -= y
      @y2 -= y
      @y3 -= y
      @y4 -= y
    end

    def x
      @x ||= 0
    end

    def x=(x)
      diff = @x - x
      self.x1 += diff
      self.x2 += diff
      self.x3 += diff
      self.x4 += diff
      @x = x
    end

    def y
      @y ||= 0
    end

    def y=(y)
      diff = @y - y
      self.y1 += diff
      self.y2 += diff
      self.y3 += diff
      self.y4 += diff
      @y = y
    end

    def size
      @size ||= 1
    end

    def size=(size)
      # should resize based on the top left point
      # offset rotation to shape
    end

    def x1
      (@x1 + x) / Camera.zoom_level + Camera.camera_position[0]
      # undo rotation/translation/zoom
    end

    def x1=(x1)
      @x1 = ((x1 + x) - Camera.camera_position[0]) * Camera.zoom_level
      # add rotation level
      # apply rotation/translation/zoom then pass to super
    end

    def y1
      (@y1 + y) / Camera.zoom_level + Camera.camera_position[1]
      # undo rotation/translation/zoom
    end

    def y1=(y1)
      @y1 = ((y1 + y) - Camera.camera_position[1]) * Camera.zoom_level
      # add rotation level
      # apply rotation/translation/zoom then pass to super
    end

    def x2
      (@x2 + x) / Camera.zoom_level + Camera.camera_position[0]
      # undo rotation/translation/zoom
    end

    def x2=(x2)
      @x2 = ((x2 + x) - Camera.camera_position[0]) * Camera.zoom_level
      # add rotation level
      # apply rotation/translation/zoom then pass to super
    end

    def y2
      (@y2 + y) / Camera.zoom_level + Camera.camera_position[1]
      # undo rotation/translation/zoom
    end

    def y2=(y2)
      @y2 = ((y2 + y) - Camera.camera_position[1]) * Camera.zoom_level
      # add rotation level
      # apply rotation/translation/zoom then pass to super
    end

    def x3
      (@x3 + x) / Camera.zoom_level + Camera.camera_position[0]
      # undo rotation/translation/zoom
    end

    def x3=(x3)
      @x1 = ((x3 + x) - Camera.camera_position[0]) * Camera.zoom_level
      # add rotation level
      # apply rotation/translation/zoom then pass to super
    end

    def y3
      (@y3 + y) / Camera.zoom_level + Camera.camera_position[1]
      # undo rotation/translation/zoom
    end

    def y3=(y3)
      @y3 = ((y3 + y) - Camera.camera_position[1]) * Camera.zoom_level
      # add rotation level
      # apply rotation/translation/zoom then pass to super
    end

    def x4
      (@x4 + x) / Camera.zoom_level + Camera.camera_position[0]
      # undo rotation/translation/zoom
    end

    def x4=(x4)
      @x4 = ((x4 + x) - Camera.camera_position[0]) * Camera.zoom_level
      # add rotation level
      # apply rotation/translation/zoom then pass to super
    end

    def y4
      (@y4 + y) / Camera.zoom_level + Camera.camera_position[1]
      # undo rotation/translation/zoom
    end

    def y4=(y4)
      @y4 = ((y4 + y) - Camera.camera_position[1]) * Camera.zoom_level
      # add rotation level
      # apply rotation/translation/zoom then pass to super
    end

    def rotation_degrees
      @rotation_degrees ||= 0
    end

    def rotate_degrees_by(degrees)
      # offset rotation to shape
    end

    def rotate_degree_to(degrees)
      # set rotation
    end
  end
  class <<self
    attr_writer :elasticity

    private

    attr_writer :camera_position_x, :camera_position_y, :zoom_level, :rotation_degrees
  end

  def self.elasticity
    @elasticity ||= 1
  end

  def self.camera_position_x
    @camera_position_x ||= 0
  end

  def self.camera_position_y
    @camera_position_y ||= 0
  end

  def self.camera_position
    [camera_position_x, camera_position_y]
  end

  def self.zoom_level
    @zoom_level ||= 1
  end

  def self.rotation_degrees
    @rotation_degrees ||= 0
  end

  def self.rotate_degrees_by(degrees)
    # offset rotation to world
  end

  def self.rotate_degree_to(degrees)
    # set rotation
  end

  def self.zoom_by(zoom)
    objects.each do |object|
      object.size *= zoom
      object.x *= zoom
      object.y *= zoom
    end
    self.zoom_level *= zoom
    move_by(Window.width / 2 * (zoom - 1),
            Window.height / 2 * (zoom - 1))
  end

  def self.zoom_to(zoom)
    zoom_by(zoom / self.zoom_level)
  end

  def self.follow(item)
    move_to(((item.x + item.size / 2) - (Window.width / 2)) / elasticity,
            ((item.y + item.size / 2) - (Window.height / 2)) / elasticity)
  end

  def self.objects
    @objects ||= []
  end

  def self.<<(item)
    item.extend QuadCameraTracker if item.is_a? Quad
    objects.push(item) unless objects.include?(item)
  end

  def self.add(item)
    self << item
  end

  def self.remove(item)
    objects.delete(item) if objects.include?(item)
  end

  def self.move_by(x, y)
    objects.each do |object|
      if object.is_a?(Image) or object.is_a?(AnimatedSquare)
        object.x -= x
        object.y -= y
      else
        object.update(x,y)
      end
    end
    self.camera_position_x += x / zoom_level
    self.camera_position_y += y / zoom_level
  end

  def self.move_to(x, y)
    self.camera_position = [x / zoom_level + camera_position[0],
                            y / zoom_level + camera_position[1]]
    objects.each do |object|
      object.x -= x
      object.y -= y
    end
  end
end
