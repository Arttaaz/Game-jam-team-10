require 'gosu'


class Player

  def initialize(image, x, y)
    @image = Gosu::Image.new(image, :tileable => true)
    @x = x
    @y = y
    @health = 100
  end

  def draw
    @image.draw(@x,@y,1)
  end

end
