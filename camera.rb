# frozen_string_literal: true

# Simulates a moving camera by manipulating objects it knows
class Camera
  class <<self
    attr_writer :elasticity

    private

    attr_writer :camera_position, :zoom_level
  end

  def self.elasticity
    @elasticity ||= 1
  end

  def self.camera_position
    @camera_position ||= [0, 0]
  end

  def self.zoom_level
    @zoom_level ||= 1
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
    objects.push(item) unless objects.include?(item)
  end

  def self.add(item)
    self << item
  end

  def self.remove(item)
    objects.delete(item) if objects.include?(item)
  end

  def self.move_by(x, y)
    camera_position[0] += x / zoom_level
    camera_position[1] += y / zoom_level
    objects.each do |object|
      object.x -= x
      object.y -= y
    end
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
