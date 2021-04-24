# frozen_string_literal: true

module Camera
  # Wraps existing variables as well as adding new methods
  # so that it can be handled by the Camera Module
  module SpriteWrapped
    # Recalculates real coordiantes
    # Use after changing variables
    def update
      angle = Camera.angle * (Math::PI / 180)
      half_width = Window.width * 0.5
      half_height = Window.height * 0.5
      offset_x = x + (width / 2)
      offset_y = y + (height / 2)
      @x = (((offset_x - Camera.x) * Math.cos(angle)) - ((offset_y - Camera.y) * Math.sin(angle))) \
        * Camera.zoom + half_width - (width * Camera.zoom / 2)
      @y = (((offset_x - Camera.x) * Math.sin(angle)) + ((offset_y - Camera.y) * Math.cos(angle))) \
        * Camera.zoom + half_height - (height * Camera.zoom / 2)
      @rotate = rotate + Camera.angle
      @width = width * Camera.zoom
      @height = height * Camera.zoom
    end

    #Methods for moving the shape

    # Wrappers for the coordinates so that
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

    def x
      @virtual_x ||= @x
    end

    def rotate
      @virtual_rotate ||= @rotate
    end

    def rotate=(rotate)
      @virtual_rotate = rotate
    end

    def width
      @virtual_width ||= @width
    end

    def width=(width)
      @virtual_width = width
    end

    def height
      @virtual_height ||= @height
    end

    def height=(height)
      @virtual_height = height
    end
  end
end
