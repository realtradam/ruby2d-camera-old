# frozen_string_literal: true

module Camera
# Wraps existing variables as well as adding new methods
# so that it can be handled by the Camera Module
  module QuadWrapped
    # Recalculates real coordiantes
    # Use after changing variables
    def update
      angle = Camera.angle * (Math::PI / 180)
      half_width = Window.width * 0.5
      half_height = Window.height * 0.5
      @x1 = (((x + x1 - Camera.x) * Math.cos(angle)) - ((y + y1 - Camera.y) * Math.sin(angle))) * Camera.zoom + half_width
      @y1 = (((x + x1 - Camera.x) * Math.sin(angle)) + ((y + y1 - Camera.y) * Math.cos(angle))) * Camera.zoom + half_height
      @x2 = (((x + x2 - Camera.x) * Math.cos(angle)) - ((y + y2 - Camera.y) * Math.sin(angle))) * Camera.zoom + half_width
      @y2 = (((x + x2 - Camera.x) * Math.sin(angle)) + ((y + y2 - Camera.y) * Math.cos(angle))) * Camera.zoom + half_height
      @x3 = (((x + x3 - Camera.x) * Math.cos(angle)) - ((y + y3 - Camera.y) * Math.sin(angle))) * Camera.zoom + half_width
      @y3 = (((x + x3 - Camera.x) * Math.sin(angle)) + ((y + y3 - Camera.y) * Math.cos(angle))) * Camera.zoom + half_height
      @x4 = (((x + x4 - Camera.x) * Math.cos(angle)) - ((y + y4 - Camera.y) * Math.sin(angle))) * Camera.zoom + half_width
      @y4 = (((x + x4 - Camera.x) * Math.sin(angle)) + ((y + y4 - Camera.y) * Math.cos(angle))) * Camera.zoom + half_height
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

    def x3
      @virtual_x3 ||= @x3
    end

    def x3=(x3)
      @virtual_x3 = x3
    end

    def y3
      @virtual_y3 ||= @y3
    end

    def y3=(y3)
      @virtual_y3 = y3
    end
    def x4
      @virtual_x3 ||= @x3
    end

    def x4=(x4)
      @virtual_x4 = x4
    end

    def y4
      @virtual_y4 ||= @y4
    end

    def y4=(y4)
      @virtual_y4 = y4
    end
  end
end

