require 'gosu'
load 'Player.rb'

class Enemy < Player

  def initialize(image, x, y)
    super
  end

  def ai(targets)
  end

  def attack(target)
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
