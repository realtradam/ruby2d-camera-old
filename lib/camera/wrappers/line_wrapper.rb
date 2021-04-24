# frozen_string_literal: true

module Camera
# Wraps existing variables as well as adding new methods
# so that it can be handled by the Camera Module
  module LineWrapped
    # Recalculates real coordiantes
    # Use after changing variables
    def redraw
      angle = Camera.angle * (Math::PI / 180)
      half_width = Window.width * 0.5
      half_height = Window.height * 0.5
      @x1 = (((x + x1 - Camera.x) * Math.cos(angle)) - ((y + y1 - Camera.y) * Math.sin(angle))) * Camera.zoom + half_width
      @y1 = (((x + x1 - Camera.x) * Math.sin(angle)) + ((y + y1 - Camera.y) * Math.cos(angle))) * Camera.zoom + half_height
      @x2 = (((x + x2 - Camera.x) * Math.cos(angle)) - ((y + y2 - Camera.y) * Math.sin(angle))) * Camera.zoom + half_width
      @y2 = (((x + x2 - Camera.x) * Math.sin(angle)) + ((y + y2 - Camera.y) * Math.cos(angle))) * Camera.zoom + half_height
      @width = width * Camera.zoom
    end

    #Methods for moving the shape
    def x
      @x ||= x1
    end

    def x=(x)
      @x = x
    end

    def y
      @y ||= y1
    end

    def y=(y)
      @y = y
    end

    # Wrappers for the coordinates so that
    # they are handled by the Camera instead
    # and for ease of programming
    def x1
      @virtual_x1 ||= @x1
    end

    def x1=(x1)
      @virtual_x1 = x1
    end

    def y1
      @virtual_y1 ||= @y1
    end

    def y1=(y1)
      @virtual_y1 = y1
    end

    def x2
      @virtual_x2 ||= @x2
    end

    def x2=(x2)
      @virtual_x2 = x2
    end

    def y2
      @virtual_y2 ||= @y2
    end

    def y2=(y2)
      @virtual_y2 = y2
    end

    def width
      @virtual_width ||= @width
    end

    def width=(width)
      @virtual_width = width
    end

    def length
      points_distance(x1, y1, x2, y2)
    end

    def contains?(x, y)
      points_distance(x1, y1, x, y) <= length &&
        points_distance(x2, y2, x, y) <= length &&
        (((y2 - y1) * x - (x2 - x1) * y + x2 * y1 - y2 * x1).abs / length) <= 0.5 * width
    end
  end
end

