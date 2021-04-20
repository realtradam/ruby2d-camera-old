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

  def self.x
    @x ||= 0
  end

  def self.x=(x)
    angle = Camera.angle * (Math::PI / 180)
    @y -= (-self.x + x) * Math.sin(-angle)
    @x -= (-self.x + x) * Math.cos(-angle)
    objects.each(&:_update)
  end

  def self.y
    @y ||= 0
  end

  def self.y=(y)
    angle = Camera.angle * (Math::PI / 180)
    @x -= -(-self.y + y) * Math.sin(-angle)
    @y -= (-self.y + y) * Math.cos(-angle)
    objects.each(&:_update)
  end

  def self.zoom
    @zoom ||= 1.0
  end

  def self.zoom=(zoom)
    #TODO
    @zoom = zoom
  end

  def self.angle
    @angle ||= 0
  end

  def self.angle=(angle)
    @angle = angle
    objects.each(&:_update)
  end
end
