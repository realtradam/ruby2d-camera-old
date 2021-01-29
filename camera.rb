# frozen_string_literal: true

require 'ruby2d'
require_relative 'quad_camera_tracker'

# Simulates a moving camera by manipulating objects it knows
class Camera
  # Is added to quads to manage how they show and modify
  # it should convert or undo the camera modification
  # such that it is as if the camera wasnt there and everything
  # is relative to the origin
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

  def self.rotate_by(degrees)
    # offset rotation to world
    objects.each do |object|
      unless object.is_a?(Image) or object.is_a?(AnimatedSquare)
        object.update(rotate: degrees)
      end
    end
    self.rotation_degrees += degrees
    self.rotation_degrees %= 360
  end

  def self.zoom_by(zoom)
    objects.each do |object|
      if object.is_a?(Image) or object.is_a?(AnimatedSquare)
        object.size *= zoom
        object.x *= zoom
        object.y *= zoom
      else
        object.update(zoom: zoom)
      end
    end
    self.zoom_level *= zoom
    move_by(Window.width / 2 * (zoom - 1),
            Window.height / 2 * (zoom - 1))
  end

  def self.zoom_to(zoom)
    zoom_by(zoom / self.zoom_level)
  end

  def self.follow(item)
    move_by(((item.x - camera_position_x - (Window.width / 2) / zoom_level) /
             (elasticity / (zoom_level * zoom_level))),
            ((item.y - camera_position_y - (Window.height / 2) / zoom_level) /
             (elasticity / (zoom_level * zoom_level))))
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
        object.update(x: x, y: y)
      end
    end
    self.camera_position_x += x / zoom_level
    self.camera_position_y += y / zoom_level
  end
# SOMETHING MESSED UP
  # with the camera position thing
  def self.move_to(x, y)
    objects.each do |object|
      if object.is_a?(Image) or object.is_a?(AnimatedSquare)
        object.x -= object.x + x
        object.y -= object.y + y
      else
        object.update(x: -Camera.camera_position_x + x, y: -Camera.camera_position_y + y)
      end
    end
    self.camera_position_x = x / zoom_level
    self.camera_position_y = y / zoom_level
=begin
    self.camera_position_x = x / zoom_level + camera_position[0]
    self.camera_position_y = y / zoom_level + camera_position[1]
    objects.each do |object|
      if object.is_a?(Image) or object.is_a?(AnimatedSquare)
        object.x -= x
        object.y -= y
      else
        object.update(x: x, y: y)
      end
    end
=end
  end
end
