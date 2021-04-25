# frozen_string_literal: true

# Is a house
class House
  def initialize(x, y)
    @objects = []
    @x = x
    @y = y
    @objects.push Image.new('assets/blobshadow.png',
                            width: 320,
                            height: 250,
                            x: x - 10,
                            y: y + 130,
                            z: 0)
    @objects.push Image.new('assets/bricktexture.png',
                            x: x,
                            y: y,
                            width: 300,
                            height: 300)
    @objects.push Square.new(x: 125 + x,
                             y: 230 + y,
                             size: 50,
                             color: 'black')
    @objects.push Circle.new(x: 125 + x,
                             y: 205 + y,
                             radius: 25,
                             color: 'black')
    @objects.push Triangle.new(x1: -5 + x,
                               y1: 16 + y,
                               x2: 310 + x,
                               y2: 14 + y,
                               x3: 150 + x,
                               y3: -75 + y,
                               color: 'red')
    @objects.push Square.new(x: 160 + x,
                             y: 20 + y,
                             size: 100,
                             color: 'brown',
                             z: 1)
    @objects.push Square.new(x: 170 + x,
                             y: 25 + y,
                             size: 80,
                             opacity: 0.5,
                             color: 'blue',
                             z: 2)
    @objects.push Rectangle.new(x: 160 + x,
                                y: 105 + y,
                                width: 100,
                                height: 20,
                                color: 'brown',
                                z: 3)
    @objects.push Line.new(x1: 210 + x,
                           y1: 105 + y,
                           x2: 210 + x,
                           y2: 25 + y,
                           width: 4,
                           color: 'brown',
                           z: 3)
    @objects.push Line.new(x1: 250 + x,
                           y1: 65 + y,
                           x2: 170 + x,
                           y2: 65 + y,
                           width: 4,
                           color: 'brown',
                           z: 3)
    @objects.push Sprite.new('./assets/sprites/alienpls-56.png',
                             x: 175 + x,
                             y: 65 + y,
                             width: 56,
                             height: 56,
                             clip_width: 56,
                             loop: true,
                             time: 35,
                             z: 1)
    @objects.last.play
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
      Text.new('Press Space To Enter House',
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

