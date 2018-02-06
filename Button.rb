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

  def isInside?(x, y, xx, yy)
    if (x >= @x+xx) && (y >= @y+yy)
      if (x <= @x+xx+@width) && (y <= @y+yy+@height)
        puts x, y
        return true
      else
        return false
      end
    end
  end

  def update(x, y)
    @x = x
    @y = y
  end

  def draw
    Gosu.draw_rect(@x,@y,@width,@height,@color, 0, :default)
    @font.draw(@text,@x+5,@y+10, 2, 1.5, 1.5 ,Gosu::Color::BLACK)
  end


end
