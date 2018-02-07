require 'gosu'

class Enemy

  attr_reader :x, :y, :race, :speed

  def initialize(image, x, y, race)
    @image = Gosu::Image.new(image, :tileable => true)
    @x = x
    @y = y
    @speed = 11
    @race = race
    @maxHealth = @health = 100
    @shield = @maxShield = 100
    @color = 0xff_ffffff
  end

  def ai(targets)
  end

  def update
    if @health == 0
      @shield = 0
      @color = Gosu::Color::GRAY
    end
  end

  def draw
    @image.draw(@x,@y,1, 1, 1, @color)
    Gosu.draw_rect(x+90, y+300, 100, 10, Gosu::Color::BLACK, 0)
    Gosu.draw_rect(x+90, y+300, (@shield *100)/@maxShield, 10, Gosu::Color::CYAN, 0)
    Gosu.draw_rect(x+90, y+315, 100, 10, Gosu::Color::BLACK, 0)
    Gosu.draw_rect(x+90, y+315, (@health *100)/@maxHealth, 10, Gosu::Color::GREEN, 0)
  end

  def isClicked?(x, y, xx)
    if (x >= @x-xx+600) && (y >= 150)
      if (x <= @x-xx+790) && (y <= 450)
        return true
      else
        return false
      end
    end
  end

end
