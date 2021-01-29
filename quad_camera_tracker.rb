# frozen_string_literal: true

module QuadCameraTracker
  def update(options = {})
    if options[:x] and options[:y]
      @x1 -= options[:x]
      @x2 -= options[:x]
      @x3 -= options[:x]
      @x4 -= options[:x]
      @y1 -= options[:y]
      @y2 -= options[:y]
      @y3 -= options[:y]
      @y4 -= options[:y]
    end
    if options[:zoom]
      @x1 *= options[:zoom]
      @x2 *= options[:zoom]
      @x3 *= options[:zoom]
      @x4 *= options[:zoom]
      @y1 *= options[:zoom]
      @y2 *= options[:zoom]
      @y3 *= options[:zoom]
      @y4 *= options[:zoom]
    end
    if options[:rotate]
      x_pivot = -x
      y_pivot = -y
      calc_angle = (Math::PI * options[:rotate]) / 180
      x_shifted1 = x1 - x_pivot
      y_shifted1 = y1 - y_pivot
      x_shifted2 = x2 - x_pivot
      y_shifted2 = y2 - y_pivot
      x_shifted3 = x3 - x_pivot
      y_shifted3 = y3 - y_pivot
      x_shifted4 = x4 - x_pivot
      y_shifted4 = y4 - y_pivot

      self.x1 = x_pivot + (x_shifted1 * Math.cos(calc_angle) - y_shifted1 * Math.sin(calc_angle))
      self.y1 = y_pivot + (x_shifted1 * Math.sin(calc_angle) + y_shifted1 * Math.cos(calc_angle))

      self.x2 = x_pivot + (x_shifted2 * Math.cos(calc_angle) - y_shifted2 * Math.sin(calc_angle))
      self.y2 = y_pivot + (x_shifted2 * Math.sin(calc_angle) + y_shifted2 * Math.cos(calc_angle))

      self.x3 = x_pivot + (x_shifted3 * Math.cos(calc_angle) - y_shifted3 * Math.sin(calc_angle))
      self.y3 = y_pivot + (x_shifted3 * Math.sin(calc_angle) + y_shifted3 * Math.cos(calc_angle))

      self.x4 = x_pivot + (x_shifted4 * Math.cos(calc_angle) - y_shifted4 * Math.sin(calc_angle))
      self.y4 = y_pivot + (x_shifted4 * Math.sin(calc_angle) + y_shifted4 * Math.cos(calc_angle))
    end
  end

  # Uses a 'fast' method of getting the center
  # perfectly accurate for squares and rectangles
  # may be inaccurate for other quadrilaterals
  def lazy_center
    [([@x1, @x2, @x3, @x4].min + [@x1, @x2, @x3, @x4].max) / 2,
     ([@y1, @y2, @y3, @y4].min + [@y1, @y2, @y3, @y4].max) / 2]
  end

  def width
    [@x1, @x2, @x3, @x4].max - [@x1, @x2, @x3, @x4].min
  end

  def height
    [@y1, @y2, @y3, @y4].max - [@y1, @y2, @y3, @y4].min
  end

  def x
    @x ||= @x1 / Camera.zoom_level + Camera.camera_position[0]
  end

  def x=(x)
    diff = x - self.x
    self.x1 += diff
    self.x2 += diff
    self.x3 += diff
    self.x4 += diff
    @x = x
  end

  def y
    @y ||= @y1 / Camera.zoom_level + Camera.camera_position[1]
  end

  def y=(y)
    diff = y - self.y
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

  def x1_debug
    @x1
  end

  def x1
    @x1 / Camera.zoom_level + Camera.camera_position[0] - x
    # undo rotation/translation/zoom
  end

  # Should modify the x1 methods so they move everything else isntead
  # this is so that x1 is always the "origin" aka 0,0 of the shape
  def x1=(x1)
    @x1 = ((x1 + x) - Camera.camera_position[0]) * Camera.zoom_level
    # add rotation level
    # apply rotation/translation/zoom then pass to super
  end

  def y1
    @y1 / Camera.zoom_level + Camera.camera_position[1] - y
    # undo rotation/translation/zoom
  end

  def y1=(y1)
    @y1 = ((y1 + y) - Camera.camera_position[1]) * Camera.zoom_level
    # add rotation level
    # apply rotation/translation/zoom then pass to super
  end

  def x2
    (@x2) / Camera.zoom_level + Camera.camera_position[0] - x
    # undo rotation/translation/zoom
  end

  def x2=(x2)
    @x2 = ((x2 + x) - Camera.camera_position[0]) * Camera.zoom_level
    # add rotation level
    # apply rotation/translation/zoom then pass to super
  end

  def y2
    (@y2) / Camera.zoom_level + Camera.camera_position[1] - y
    # undo rotation/translation/zoom
  end

  def y2=(y2)
    @y2 = ((y2 + y) - Camera.camera_position[1]) * Camera.zoom_level
    # add rotation level
    # apply rotation/translation/zoom then pass to super
  end

  def x3
    (@x3) / Camera.zoom_level + Camera.camera_position[0] - x
    # undo rotation/translation/zoom
  end

  def x3=(x3)
    @x3 = ((x3 + x) - Camera.camera_position[0]) * Camera.zoom_level
    # add rotation level
    # apply rotation/translation/zoom then pass to super
  end

  def y3
    (@y3) / Camera.zoom_level + Camera.camera_position[1] - y
    # undo rotation/translation/zoom
  end

  def y3=(y3)
    @y3 = ((y3 + y) - Camera.camera_position[1]) * Camera.zoom_level
    # add rotation level
    # apply rotation/translation/zoom then pass to super
  end

  def x4
    @x4 / Camera.zoom_level + Camera.camera_position[0] - x
    # undo rotation/translation/zoom
  end

  def x4=(x4)
    @x4 = ((x4 + x) - Camera.camera_position[0]) * Camera.zoom_level
    # add rotation level
    # apply rotation/translation/zoom then pass to super
  end

  def y4
    @y4 / Camera.zoom_level + Camera.camera_position[1] - y
    # undo rotation/translation/zoom
  end

  def y4=(y4)
    @y4 = ((y4 + y) - Camera.camera_position[1]) * Camera.zoom_level
    # add rotation level
    # apply rotation/translation/zoom then pass to super
  end

  attr_writer :rotation_degrees

  def rotation_degrees
    @rotation_degrees ||= 0
  end

  def rotate_relative(x_pivot, y_pivot, angle)
    self.rotation_degrees += angle
    self.rotation_degrees %= 360
    calc_angle = (Math::PI * angle) / 180
    x_shifted1 = self.x1 - x_pivot
    y_shifted1 = self.y1 - y_pivot
    x_shifted2 = self.x2 - x_pivot
    y_shifted2 = self.y2 - y_pivot
    x_shifted3 = self.x3 - x_pivot
    y_shifted3 = self.y3 - y_pivot
    x_shifted4 = self.x4 - x_pivot
    y_shifted4 = self.y4 - y_pivot

    # Used to update x and y later in the code
    x1_old = self.x1
    y1_old = self.y1

    self.x1 = x_pivot + (x_shifted1 * Math.cos(calc_angle) - y_shifted1 * Math.sin(calc_angle))
    self.y1 = y_pivot + (x_shifted1 * Math.sin(calc_angle) + y_shifted1 * Math.cos(calc_angle))

    self.x2 = x_pivot + (x_shifted2 * Math.cos(calc_angle) - y_shifted2 * Math.sin(calc_angle))
    self.y2 = y_pivot + (x_shifted2 * Math.sin(calc_angle) + y_shifted2 * Math.cos(calc_angle))

    self.x3 = x_pivot + (x_shifted3 * Math.cos(calc_angle) - y_shifted3 * Math.sin(calc_angle))
    self.y3 = y_pivot + (x_shifted3 * Math.sin(calc_angle) + y_shifted3 * Math.cos(calc_angle))

    self.x4 = x_pivot + (x_shifted4 * Math.cos(calc_angle) - y_shifted4 * Math.sin(calc_angle))
    self.y4 = y_pivot + (x_shifted4 * Math.sin(calc_angle) + y_shifted4 * Math.cos(calc_angle))

    # Updates x and y to be on the origin correctly
    @x += -x1_old + self.x1
    @y += -y1_old + self.y1
  end

  def rotate(angle)
    rotate_relative(0, 0, angle)
  end
end
