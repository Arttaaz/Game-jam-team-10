require 'gosu'
load 'Skill.rb'


class Player

  attr_reader :x, :y, :health, :maxHealth, :maxPower, :power, :maxShield, :shield, :speed, :phy_def, :eng_def, :damage, :skills

  def initialize(image, x, y)
    @image = Gosu::Image.new(image, :tileable => true)
    @x = x
    @y = y
    @maxHealth = 100
    @health = 80
    @maxPower = 100
    @power = 100
    @maxShield = 100
    @shield = 100
    @speed = 12
    @phy_def = 8
    @eng_def = 8
    @damage = 35
  end

  def move(x,y)
    @x = @x + x
    @y = @y + y
  end

  def draw
    @image.draw(@x,@y,1)
    Gosu.draw_rect(x, y+300, 100, 10, Gosu::Color::BLACK, 0)
    Gosu.draw_rect(x, y+300, @shield*100/@maxShield, 10, Gosu::Color::CYAN, 0)
    Gosu.draw_rect(x, y+315, 100, 10, Gosu::Color::BLACK, 0)
    Gosu.draw_rect(x, y+315, @health*100/@maxHealth, 10, Gosu::Color::RED, 0)
    Gosu.draw_rect(x, y+330, 100, 10, Gosu::Color::BLACK, 0)
    Gosu.draw_rect(x, y+330, @power*100/@maxPower, 10, Gosu::Color::GREEN, 0)
  end

end
