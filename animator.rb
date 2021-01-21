
class AnimatedSquare
  def initialize(x: '0', y: '0', size: 10, color: 'random')
    @speed = (1..5).to_a.sample
    @square = Square.new(x: x, y: y, size: size, color: color)
    @axis = (0..1).to_a.sample
    if @axis == 0
      @range = [(((x-(250..500).to_a.sample)..x).to_a.sample),((x..(x+(250..500).to_a.sample)).to_a.sample)]
    else
      @range = [(((y-(250..500).to_a.sample)..y).to_a.sample),((y..(y+(250..500).to_a.sample)).to_a.sample)]
    end
  end
  def x
    @square.x
  end
  def x= x
    @square.x = x
  end

  def y
    @square.y
  end
  def y= y
    @square.y = y
  end

  def size
    @square.size
  end
  def size= size
    @square.size = size
  end



  def update(offset, zoom)
    width_zoom_offset = Window.width/2 * (zoom-1)
    height_zoom_offset = Window.height/2 * (zoom-1)
    if @axis == 0
      @square.x += @speed * zoom
      if @square.x >= ((@range[1] - offset[0]))
        @speed = -(@speed.abs)
      elsif @square.x <= ((@range[0] - offset[0]))
        @speed = @speed.abs
      end
    else
      @square.y += @speed * zoom
      if @square.y >= ((@range[1] - offset[1]))
        @speed = -(@speed.abs)
      elsif @square.y <= ((@range[0] - offset[1]))
        @speed = @speed.abs
      end
    end
  end
end
