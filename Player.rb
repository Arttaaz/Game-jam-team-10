require 'gosu'
load 'Skill.rb'


class Player


  attr_reader :x, :y, :health, :maxHealth, :maxPower, :power, :powRegen, :dmgReduc, :maxShield, :shield, :speed, :phy_def, :eng_def, :damage, :skills, :class, :race

  def initialize(image, x, y)
    @races = ["humain", "robot", "infecté"]
    @classes = ["Soldat", "Scientifique", "Ingénieur"]
    @image = Gosu::Image.new(image, :tileable => true)
    @x = x
    @y = y
    @dmgReduc = 0
    @race = @races[rand(0..2)]
    @class = @classes[rand(0..2)]
    redefStats(@race)
  end

  def move(x,y)
    @x = @x + x
    @y = @y + y
  end

  def draw
    @image.draw(@x,@y,1)
    Gosu.draw_rect(x, y+300, 100, 10, Gosu::Color::BLACK, 0)
    Gosu.draw_rect(x, y+300, (@shield *100)/@maxShield, 10, Gosu::Color::CYAN, 0)
    Gosu.draw_rect(x, y+315, 100, 10, Gosu::Color::BLACK, 0)
    Gosu.draw_rect(x, y+315, (@health *100)/@maxHealth, 10, Gosu::Color::RED, 0)
    Gosu.draw_rect(x, y+330, 100, 10, Gosu::Color::BLACK, 0)
    Gosu.draw_rect(x, y+330, (@power *100)/@maxPower, 10, Gosu::Color::FUCHSIA, 0)
  end

  def redefStats(race)
    if @race == @races[0]
      @maxHealth = @health = rand(100..200)
      @maxShield = @shield = rand(40..60)
      @maxPower = @power = 100
      @powRegen = 10
      @damage = rand(35..45)
      @phy_def = rand(8..12)
      @eng_def = rand(8..12)
      @speed = rand(12..18)
    elsif @race == @races[1]
      @maxHealth = @health = rand(70..90)
      @maxShield = @shield = rand(70..90)
      @maxPower = @maxPower = 120
      @powRegen = 12
      @damage = rand(45..60)
      @phy_def = rand(4..8)
      @eng_def = rand(6..12)
      @speed = rand(14..20)
    else #@race == @races[2]
      @maxHealth = @health = rand(140..180)
      @maxShield = @shield = 1000 #lààààààà c'est 000000
      @maxPower = @power = 80
      @powRegen = 8
      @damage = rand(20..30)
      @phy_def = rand(14..18)
      @eng_def = rand(10..14)
      @speed = rand(8..16)
    end
  end

end
