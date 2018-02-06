require 'gosu'

class Button

  def initialize(text, x, y, width, height, color, font)
    @text = text
    @x = x
    @y = y
    @width = width
    @height = height
    @color = color
    @font = font
  end

  def draw
    Gosu.draw_rect(@x,@y,@width,@height,@color, 0, :default)
    @font.draw(@text,@x+30,@y+10, 2, 1.5, 1.5 ,Gosu::Color::BLACK)

  end


end
