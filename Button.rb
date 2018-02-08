require 'gosu'

class Button

  attr_accessor :priority

  def initialize(text, x, y, width, height, priority,color, font)
    @text = text
    @x = x
    @y = y
    @width = width
    @height = height
    @color = color
    @font = font
    @priority = priority
  end

  def isClicked?(x, y, xx, yy) #xx is x camera translation yy is y camera translation
    if (x >= @x+xx) && (y >= @y+yy)
      if (x <= @x+xx+@width) && (y <= @y+yy+@height)
        return true
      else
        return false
      end
    end
  end

  def isClickedTS?(x, y) #TitleScreen
    if (x >= @x) && (y >= @y)
      if (x <= @x+@width) && (y <= @y+@height)
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
    Gosu.draw_rect(@x,@y,@width,@height,@color, @priority, :default)
    @font.draw(@text,@x+5,@y+10, @priority, 1.5, 1.5 ,Gosu::Color::BLACK)
  end



end
