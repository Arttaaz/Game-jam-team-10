require 'gosu'

class Enemy

  attr_reader :x, :y, :race

  def initialize(image, x, y, race)
    @image = image
    @x = x
    @y = y
    @race = race
    @health = 100
    @shield = 100
  end

  def ai
  end

  def update
  end

  def draw
    @image.draw(@x,@y,1)
    Gosu.draw_rect(x, y+300, 100, 10, Gosu::Color::BLACK, 0)
    Gosu.draw_rect(x, y+300, (@shield *100)/@maxShield, 10, Gosu::Color::CYAN, 0)
    Gosu.draw_rect(x, y+315, 100, 10, Gosu::Color::BLACK, 0)
    Gosu.draw_rect(x, y+315, (@health *100)/@maxHealth, 10, Gosu::Color::RED, 0)
  end

end
