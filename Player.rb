require 'gosu'
load 'Skill.rb'


class Player

  @races = ["Human", "Robot", "Infected"]
  @classes = ["Soldier", "Scientist", "Engineer"]
  attr_reader :x, :y, :health, :maxHealth, :maxPower, :power, :maxShield, :shield, :speed, :phy_def, :eng_def, :damage, :skills, :class, :race

  def initialize(image, x, y)
    @image = Gosu::Image.new(image, :tileable => true)
    @x = x
    @y = y
    @maxHealth = @health = 100
    @maxPower = @power = 100
    @maxShield = @shield = 100
    @speed = 12
    @phy_def = 8
    @eng_def = 8
    @damage = 35
    @race = "Infected"#@races[1]
    @class = "Scientist"#@classes[1]
    redefStats(@race)
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

  def redefStats(race)
    if @race == "Human"#@races[0]
      @maxHealth = rand(100..200)
      @maxShield = rand(40..60)
      @maxPower = 100
      @damage = rand(35..45)
      @phy_def = rand(8..12)
      @eng_def = rand(8..12)
      @speed = rand(12..18)
    elsif @race == "Robot"#@races[1]
      @maxHealth = rand(70..90)
      @maxShield = rand(70..90)
      @maxPower = 120
      @damage = rand(45..60)
      @phy_def = rand(4..8)
      @eng_def = rand(6..12)
      @speed = rand(14..20)
    else #@race == "Infected" or @races[2]
      @maxHealth = rand(140..180)
      @maxShield = 1000 #lààààààà c'est 000000
      @maxPower = 80
      @damage = rand(20..30)
      @phy_def = rand(14..18)
      @eng_def = rand(10..14)
      @speed = rand(8..16)
    end
  end

end
