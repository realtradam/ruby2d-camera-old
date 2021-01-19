
class Camera
  
  def self.elasticity
    @elasticity ||= 1
  end

  def self.elasticity= speed
    @elasticity = speed
  end

  def self.follow item
    self.move_to((item.x - (Window.width / 2))/self.elasticity,
                 (item.y - (Window.height / 2))/self.elasticity)
  end

  def self.objects
    @objects ||= []
  end

  def self.<< item
    unless self.objects.include?(item)
      self.objects.push(item)
    end
  end

  def self.add item
    self << item
  end

  def self.remove item
    if self.objects.include?(item)
      self.objects.delete(item)
    end
  end

  
  def self.move_by(x,y)
    self.camera_position[0] += x
    self.camera_position[1] += y
    objects.each do |object|
      object.x -= x
      object.y -= y
    end
  end
  def self.move_to(x,y)
    self.camera_position = [x+camera_position[0],y+camera_position[1]]
    objects.each do |object|
      object.x -= x
      object.y -= y
    end
  end
  
  def self.camera_position
    @camera_position ||= [0,0]
  end

  private

  def self.camera_position= array
    @camera_position = array
  end

  
end
