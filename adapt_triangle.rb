# frozen_string_literal: true

module AdaptTriangle

  def _translate_x(x)
    @x1 += x
    @x2 += x
    @x3 += x
  end

  def _translate_y(y)
    @y1 += y
    @y2 += y
    @y3 += y
  end

  def _rotate(angle)
    @x1 = ((@x1) * Math.cos(angle)) - ((@y1) * Math.sin(angle))
    @y1 = ((@x1) * Math.sin(angle)) + ((@y1) * Math.cos(angle))
    @x2 = ((@x2) * Math.cos(angle)) - ((@y2) * Math.sin(angle))
    @y2 = ((@x2) * Math.sin(angle)) + ((@y2) * Math.cos(angle))
    @x3 = ((@x3) * Math.cos(angle)) - ((@y3) * Math.sin(angle))
    @y3 = ((@x3) * Math.sin(angle)) + ((@y3) * Math.cos(angle))
  end

  def _update
    angle = Camera.angle * (Math::PI / 180)
    @x1 = (((x + x1 - Camera.x) * Math.cos(angle)) - ((y + y1 - Camera.y) * Math.sin(angle))) * Camera.zoom
    @y1 = (((x + x1 - Camera.x) * Math.sin(angle)) + ((y + y1 - Camera.y) * Math.cos(angle))) * Camera.zoom
    @x2 = (((x + x2 - Camera.x) * Math.cos(angle)) - ((y + y2 - Camera.y) * Math.sin(angle))) * Camera.zoom
    @y2 = (((x + x2 - Camera.x) * Math.sin(angle)) + ((y + y2 - Camera.y) * Math.cos(angle))) * Camera.zoom
    @x3 = (((x + x3 - Camera.x) * Math.cos(angle)) - ((y + y3 - Camera.y) * Math.sin(angle))) * Camera.zoom
    @y3 = (((x + x3 - Camera.x) * Math.sin(angle)) + ((y + y3 - Camera.y) * Math.cos(angle))) * Camera.zoom
  end

  def _x1
    @x1
  end

  def _y1
    @y1
  end

  def x
    @x ||= x1
  end

  def x=(x)
    #diff = x - self.x
    #self.x1 += diff
    #self.x2 += diff
    #self.x3 += diff
    @x = x
    _update
  end

  def y
    @y ||= y1
  end

  def y=(y)
    #diff = y - self.y
    #self.y1 += diff
    #self.y2 += diff
    #self.y3 += diff
    @y = y
  end

  #undo rotation
  def x1
    @virtual_x1 ||= @x1
    #(@x1 * Math.cos(-Camera.angle)) - (@y1 * Math.sin(-Camera.angle)) - Camera.x
  end

  #difference between 'x1' and undone rotation > then rotated
  def x1=(x1)
    @virtual_x1 = x1
    _update
    #temp = self.x1
    #@x1 += ((x1 - temp) * Math.cos(Camera.angle))
    #@y1 += ((x1 - temp) * Math.sin(Camera.angle))
  end

  def y1
    @virtual_y1 ||= @y1
    #(@x1 * Math.sin(-Camera.angle)) + (@y1 * Math.cos(-Camera.angle)) - Camera.y
  end

  def y1=(y1)
    @virtual_y1 = y1
    _update
    #temp = self.y1
    #@x1 += -((y1 - temp) * Math.sin(Camera.angle))
    #@y1 += ((y1 - temp) * Math.cos(Camera.angle))
  end

  def x2
    @virtual_x2 ||= @x2
  end

  def x2=(x2)
    @virtual_x2 = x2
    _update
  end

  def y2
    @virtual_y2 ||= @y2
  end

  def y2=(y2)
    @virtual_y2 = y2
    _update
  end

  def x3
    @virtual_x3 ||= @x3
  end

  def x3=(x3)
    @virtual_x3 = x3
    _update
  end

  def y3
    @virtual_y3 ||= @y3
  end

  def y3=(y3)
    @virtual_y3 = y3
    _update
  end
end

