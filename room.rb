# frozen_string_literal: true

# Is a house
class Room
  def initialize(x, y)
    @objects = []
    @x = x
    @y = y
    roomy = 155
    @objects.push Square.new(x: 125 + x,
                             y: 230 + y,
                             size: 50,
                             color: 'blue',
                             z: 3)
    @objects.push Circle.new(x: 125 + x,
                             y: 205 + y,
                             radius: 25,
                             sectors: 64,
                             color: 'blue',
                             z: 3)
    @objects.push Quad.new(x1: 50 + x,
                           y1: 130 + y + roomy,
                           x2: 125 + x,
                           y2: 180 + y + roomy,
                           x3: 325 + x,
                           y3: 180 + y + roomy,
                           x4: 250 + x,
                           y4: 130 + y + roomy,
                           color: 'aqua',
                           z: 1)
    @objects.push Quad.new(x1: 50 + x,
                           y1: 45 + y + roomy,
                           x2: 50 + x,
                           y2: 125 + y + roomy,
                           x3: 250 + x,
                           y3: 125 + y + roomy,
                           x4: 250 + x,
                           y4: 45 + y + roomy,
                           color: 'orange',
                           z: 1)
    @objects.push Quad.new(x1: 255 + x,
                           y1: 45 + y + roomy,
                           x2: 255 + x,
                           y2: 125 + y + roomy,
                           x3: 330 + x,
                           y3: 175 + y + roomy,
                           x4: 330 + x,
                           y4: 95 + y + roomy,
                           color: 'olive',
                           z: 1)
    @objects.push Sprite.new('./assets/sprites/blobdance-128.png',
                             x: 250 + x,
                             y: 135 + y + roomy,
                             width: 40,
                             height: 40,
                             clip_width: 128,
                             loop: true,
                             time: 24,
                             z: 5)
    @objects.last.play
    @objects.push Image.new(
      'assets/blobshadow.png',
      x: 250 + x - 2 - 5,
      y: 135 + y + roomy + 42 - 15,
      width: 52,
      height: 10,
      z: 4
    )
    @objects.push Sprite.new('./assets/sprites/dance2-112.png',
                             x: 95 + x,
                             y: 115 + y + roomy,
                             width: 40,
                             height: 40,
                             clip_width: 112,
                             loop: true,
                             time: 13,
                             z: 5)
    @objects.last.play
    @objects.push Image.new(
      'assets/blobshadow.png',
      x: 95 + x - 2 - 5,
      y: 115 + y + roomy + 42 - 10,
      width: 52,
      height: 10,
      z: 4
    )
    @objects.push Sprite.new('./assets/sprites/dancer-128.png',
                             x: 175 + x,
                             y: 120 + y + roomy,
                             width: 45,
                             height: 45,
                             clip_width: 128,
                             loop: true,
                             time: 60,
                             z: 5)
    @objects.last.play
    @objects.push Image.new(
      'assets/blobshadow.png',
      x: 175 + x - 2 - 5,
      y: 120 + y + roomy + 42 - 5,
      width: 52,
      height: 10,
      z: 4
    )
    @objects.each do |item|
      Camera << item
    end
  end

  def remove
    @objects.each do |item|
      Camera.remove item
      item.remove
    end
  end

  def visted_by?(character)
    x = @x + 80
    y = @y + 160
    if character.x >= x && character.x <= (x + (character.width * 2)) && character.y > y && character.y <= (y + (character.height * 2))
      Text.new('Press Space To Exit House',
               x: x + 70,
               y: y + 30,
               color: 'white',
               z: 98,
               size: 25.0)
    else
      nil
    end
  end
end

