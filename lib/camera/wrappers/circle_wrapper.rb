# frozen_string_literal: true

module Camera
# Wraps existing variables as well as adding new methods
# so that it can be handled by the Camera Module
  module CircleWrapped
    # Recalculates real coordiantes
    # Use after changing variables
    def redraw
      angle = Camera.angle * (Math::PI / 180)
      half_width = Window.width * 0.5
      half_height = Window.height * 0.5
      @x = (((x - Camera.x) * Math.cos(angle)) - ((y - Camera.y) * Math.sin(angle))) * Camera.zoom + half_width
      @y = (((x - Camera.x) * Math.sin(angle)) + ((y - Camera.y) * Math.cos(angle))) * Camera.zoom + half_height
      @radius = radius * Camera.zoom
    end

    # Methods for moving the shape as well as
    # wrappers for the coordinates so that
    # they are handled by the Camera instead
    # and for ease of programming
    def x
      @virtual_x ||= @x
    end

    def x=(x)
      @virtual_x = x
    end

    def y
      @virtual_y ||= @y
    end

    def y=(y)
      @virtual_y = y
    end

    def radius
      @virtual_radius ||= @radius
    end

    def radius=(radius)
      @virtual_radius = radius
    end
  end
end

