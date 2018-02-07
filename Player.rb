require 'gosu'
load 'Skill.rb'


class Player


  attr_reader :active, :x, :vel_x, :distance, :y, :health, :maxHealth, :maxPower, :power, :powRegen, :dmgReduc, :maxShield, :shield, :speed, :phy_def, :eng_def, :damage, :skills, :class, :race, :exp, :expBonus, :money, :moneyBonus
  attr_accessor :active, :vel_x

  def initialize(image, x, y)
    @skills = [ [Type::ACTIVE,"skill"] , [Type::PASSIVE,"passive"] ] #array is like [ [active/passive, skill name], [active/passive, skill name]]
    @races = ["Humain", "Robot", "Infecté"]
    @classes = ["Soldat", "Scientifique", "Ingénieur"]
    @image = Gosu::Image.new(image, :tileable => true)
    @active = false
    @x = x
    @vel_x = 0
    @distance = 0 #distance moved
    @y = y
    @dmgReduc = 0 #%
    @exp = 0
    @expBonus = 0 #%
    @money = 0
    @moneyBonus = 0 #%
    @race = @races[rand(0..2)]
    @class = @classes[rand(0..2)]
    redefStats(@race)
    @color = 0xff_ffffff
  end

  def move(x,y)
    @x = @x + x
    @y = @y + y
  end

  def draw
    @image.draw(@x,@y,1, 1, 1, @color)
    Gosu.draw_rect(x, y+300, 100, 10, Gosu::Color::BLACK, 0)
    Gosu.draw_rect(x, y+300, (@shield *100)/@maxShield, 10, Gosu::Color::CYAN, 0)
    Gosu.draw_rect(x, y+315, 100, 10, Gosu::Color::BLACK, 0)
    Gosu.draw_rect(x, y+315, (@health *100)/@maxHealth, 10, Gosu::Color::GREEN, 0)
    Gosu.draw_rect(x, y+330, 100, 10, Gosu::Color::BLACK, 0)
    Gosu.draw_rect(x, y+330, (@power *100)/@maxPower, 10, Gosu::Color::FUCHSIA, 0)
  end

  def update
    if @health == 0
      @shield = 0
      @power = 0
      @color = Gosu::Color::GRAY
    end

    if @vel_x != 0
      self.move(@vel_x, 0)
      @distance = @distance + @vel_x
      if @distance == 1200 || distance == -1200
        @distance = 0
        @vel_x = 0
      end
    end
  end

  def redefStats(race)
    if @race == @races[0] #humain
      @maxHealth = @health = rand(100..200)
      @maxShield = @shield = rand(40..60)
      @maxPower = @power = 100
      @powRegen = 10
      @damage = rand(35..45)
      @phy_def = rand(8..12)
      @eng_def = rand(8..12)
      @speed = rand(12..18)
    elsif @race == @races[1] #robot
      @maxHealth = @health = rand(70..90)
      @maxShield = @shield = rand(70..90)
      @maxPower = @power = 120
      @powRegen = 12
      @damage = rand(45..60)
      @phy_def = rand(4..8)
      @eng_def = rand(6..12)
      @speed = rand(14..20)
    else #@race == @races[2]   infested
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

  def levelup
    #todo
  end

  def isClicked?(x, y, xx)
    if (x >= @x-xx+100) && (y >= 150)
      if (x <= @x-xx+190) && (y <= 450)
        return true
      else
        return false
      end
    end
  end

end
