# frozen_string_literal: true

module Camera
  # Wraps existing variables as well as adding new methods
  # so that it can be handled by the Camera Module
  module SquareWrapped
    # Recalculates real coordiantes
    # Use after changing variables
    def update
      angle = Camera.angle * (Math::PI / 180)
      half_size = Window.size * 0.5
      offset_x = x + (width / 2)
      offset_y = y + (height / 2)
      @x = (((offset_x - Camera.x) * Math.cos(angle)) - ((offset_y - Camera.y) * Math.sin(angle))) \
        * Camera.zoom + half_size #- (size * Camera.zoom / 2)
      @y = (((offset_x - Camera.x) * Math.sin(angle)) + ((offset_y - Camera.y) * Math.cos(angle))) \
        * Camera.zoom + half_height #- (size * Camera.zoom / 2)
      @rotate = rotate + Camera.angle
      @size = size * Camera.zoom
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

    def size
      @virtual_size ||= @size
    end

    def size=(size)
      @virtual_size = size
    end
  end
end
