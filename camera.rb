# frozen_string_literal: true

require_relative 'adapt_triangle'

module Camera

  class <<self
    private
    def objects
      @objects ||= []
    end
  end

  def self.<<(item)
    item.extend AdaptTriangle if item.is_a? Triangle
    objects.push(item) unless objects.include?(item)
  end

  def self.center_x
    x + ((Window.width / 2) * (1/zoom))
  end

  def self.center_x=(center_x)
    @x = center_x - ((Window.width / 2) )#* (1/zoom))
    objects.each(&:_update)
  end

  def self.center_y
    y + ((Window.height / 2) )#* (1/zoom))
  end

  def self.center_y=(center_y)
    @y = center_y - ((Window.height / 2) )#* (1/zoom))
    objects.each(&:_update)
  end
=begin
  def self.center(center_x, center_y)
    self.center_y = center_y
    self.center_x = center_y
    #@y = center_y
    #@x = center_x
    angle = Math::PI / 180 * (Camera.angle + (1 * 45))
    offset_angle = Math::PI / 180 * 45
    x = (Math.cos(angle) - Math.cos(offset_angle)) * (Window.width/2) * Math.sqrt(2) * (1 / zoom)
    y = (Math.sin(angle) - Math.sin(offset_angle)) * (Window.height/2) * Math.sqrt(2) * (1 / zoom)
    @x += x
    @y += y
    #@x = x + ((pivot_x - x) * Math.cos(angle)) - ((pivot_y - y) * Math.sin(angle))
    #@y = y + ((pivot_x - x) * Math.sin(angle)) + ((pivot_y - y) * Math.cos(angle))
    objects.each(&:_update)
  end
=end
  def self._x(x)
    @x += x
    objects.each(&:_update)
  end
  
  def self._y(y)
    @y += y
    objects.each(&:_update)
  end

  def self.x
    @x ||= 0
  end

  def self.x=(x)
    angle = Camera.angle * (Math::PI / 180)
    @y += (x - self.x) * Math.sin(-angle)
    @x += (x - self.x) * Math.cos(-angle)
    objects.each(&:_update)
  end

  def self.y
    @y ||= 0
  end

  def self.y=(y)
    angle = Camera.angle * (Math::PI / 180)
    @x += -(y - self.y) * Math.sin(-angle)
    @y += (y - self.y) * Math.cos(-angle)
    objects.each(&:_update)
  end

  def self.zoom
    @zoom ||= 1.0
  end

  def self.zoom=(zoom)
    if zoom != self.zoom
      shift = (Window.width - Window.height) / 2
      #temp = [center_x, center_y]
      temp = [0, center_y]
      @zoom = zoom
      self.center_x = temp[0]
      self.center_y = temp[1]
      objects.each(&:_update)
    end
  end

  def self.angle
    @angle ||= 0
  end

  def self.angle=(angle)
    @angle = angle
    objects.each(&:_update)
  end
end
