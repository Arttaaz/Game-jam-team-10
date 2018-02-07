require 'gosu'
load 'Skill.rb'


class Player



  attr_reader :name, :active, :x, :vel_x, :distance, :y, :health, :maxHealth, :maxPower, :power, :powRegen, :dmgReduc, :maxShield, :shield, :speed, :phy_def, :eng_def, :damage, :skills, :class, :race, :exp, :expBonus
  attr_accessor :active, :vel_x, :health

  def initialize(image, x, y, race = "d")
    @skills = [ [Type::ACTIVE,"skill"] , [Type::PASSIVE,"passive"] ] #array is like [ [active/passive, skill object], [active/passive, skill object]]
    @races = ["Humain", "Robot"]
    @@humanNames = ["Jony Phelley", "Patry Garcia", "Jesse Patte", "Randy Scotte", "Effreyne Johnson", "Joshua Hayeson", "Raymy Colly", "Wayne Hezal", "Mase Carte", "Willie Warte", "Romain Fecher", "Arttaaz", "AoRailgun", "Gathzen", "Elvung"]
    @@robotNames = ["Ash", "Shrimp", "Cylinder", "Andy Roid", "Onproid", "Otid", "Bit", "Screwie", "Rubber", "Corius", "Ulx", "Aja"]
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
    @race = race
    @race = @races[rand(0..1)] if @race == "d"
    if @race == "Humain"
      index = rand(@@humanNames.size)
      @name = @@humanNames[index]
      @@humanNames.delete_at(index)
    else
      index = rand(@@robotNames.size)
      @name = @@robotNames[index]
      @@robotNames.delete_at(index)
    end
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
    if @health <= 0
      @health = 0
      @shield = 0
      @power = 0
      @color = Gosu::Color::GRAY
    end

    if @exp == 10
      self.levelup
      @exp = 0
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
    case(@race)
    when "Humain"
      @health += 20
      @maxHealth += 20
      @shield += 5
      @maxShield +=5
      @power += 10
      @maxPower += 10
      @powRegen += 2
      @damage += 5
      @phy_def += 2
      @eng_def += 2
      @speed += 1
    when "Robot"
      @health += 5
      @maxHealth += 5
      @shield += 20
      @maxShield += 20
      @power += 15
      @maxPower += 15
      @powRegen += 4
      @damage += 7
      @phy_def += 1
      @eng_def += 2
      @speed += 2
    else
      @health += 25
      @maxHealth += 25
      @shield += 0
      @maxShield += 0
      @power += 5
      @maxPower += 5
      @powRegen += 3
      @damage += 4
      @phy_def += 5
      @eng_def += 3
      @speed += 1
    end
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
