# frozen_string_literal: true

module QuadCameraTracker
  def update(zoom: 1, x: 0, y: 0)
    if x != 0 or y != 0
      @x1 -= x
      @x2 -= x
      @x3 -= x
      @x4 -= x
      @y1 -= y
      @y2 -= y
      @y3 -= y
      @y4 -= y
    end
    if zoom != 1
      @x1 *= zoom
      @x2 *= zoom
      @x3 *= zoom
      @x4 *= zoom
      @y1 *= zoom
      @y2 *= zoom
      @y3 *= zoom
      @y4 *= zoom
    end
  end

  def true_center
    [[@x1, @x2, @x3, @x4].min, [@y1, @y2, @y3, @y4].min]
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

  def x1
    @x1 / Camera.zoom_level + Camera.camera_position[0] - x
    # undo rotation/translation/zoom
  end

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

  def rotate(x_pivot, y_pivot, angle)
    self.rotation_degrees += angle
    self.rotation_degrees %= 360
    @angle = (Math::PI * angle) / 180
    x_shifted1 = self.x1 - x_pivot
    y_shifted1 = self.y1 - y_pivot
    x_shifted2 = self.x2 - x_pivot
    y_shifted2 = self.y2 - y_pivot
    x_shifted3 = self.x3 - x_pivot
    y_shifted3 = self.y3 - y_pivot
    x_shifted4 = self.x4 - x_pivot
    y_shifted4 = self.y4 - y_pivot

    x1_old = self.x1
    y1_old = self.y1

    self.x1 = x_pivot + (x_shifted1 * Math.cos(@angle) - y_shifted1 * Math.sin(@angle))
    self.y1 = y_pivot + (x_shifted1 * Math.sin(@angle) + y_shifted1 * Math.cos(@angle))

    self.x2 = x_pivot + (x_shifted2 * Math.cos(@angle) - y_shifted2 * Math.sin(@angle))
    self.y2 = y_pivot + (x_shifted2 * Math.sin(@angle) + y_shifted2 * Math.cos(@angle))

    self.x3 = x_pivot + (x_shifted3 * Math.cos(@angle) - y_shifted3 * Math.sin(@angle))
    self.y3 = y_pivot + (x_shifted3 * Math.sin(@angle) + y_shifted3 * Math.cos(@angle))

    self.x4 = x_pivot + (x_shifted4 * Math.cos(@angle) - y_shifted4 * Math.sin(@angle))
    self.y4 = y_pivot + (x_shifted4 * Math.sin(@angle) + y_shifted4 * Math.cos(@angle))

    @x += -x1_old + self.x1
    @y += -y1_old + self.y1
  end
end
