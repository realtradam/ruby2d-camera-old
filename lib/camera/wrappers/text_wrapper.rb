# frozen_string_literal: true

module Camera
  # Wraps existing variables as well as adding new methods
  # so that it can be handled by the Camera Module
  # TODO: note that text could not be resized at the current iteration
  # of Ruby2D so the math needs to be changed compensate for this.
  # When Ruby2D gets updated to allow text resizing the math will need
  # to be corrected again(see image_wrapper.rb for reference, that has
  # math that allows for resizing)
  module TextWrapped
    @center = false

    # Recalculates real coordiantes
    # Use after changing variables
    def redraw
      angle = Camera.angle * (Math::PI / 180)
      half_width = Window.width * 0.5
      half_height = Window.height * 0.5
      if center
      offset_y = y + (Camera.zoom / 2)
      offset_x = x + (Camera.zoom / 2)
      else
      offset_x = x + (width / Camera.zoom / 2)
      offset_y = y + (height / Camera.zoom / 2)
      end
      @x = (((offset_x - Camera.x) * Math.cos(angle)) - ((offset_y - Camera.y) * Math.sin(angle))) \
        * Camera.zoom + half_width - (width / 2)
      @y = (((offset_x - Camera.x) * Math.sin(angle)) + ((offset_y - Camera.y) * Math.cos(angle))) \
        * Camera.zoom + half_height - (height / 2)
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

    def center
      @center
    end

    def center=(center)
      @center = center
    end
  end
end
