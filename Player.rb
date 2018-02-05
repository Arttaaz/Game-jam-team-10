require 'gosu'


class Player

  attr_reader :x, :y, :health

  def initialize(image, x, y)
    @image = Gosu::Image.new(image, :tileable => true)
    @x = x
    @y = y
    @health = 100
  end

  def move(x,y)
    @x = @x + x
    @y = @y + y
  end

  def draw
    @image.draw(@x,@y,1)
  end

end
