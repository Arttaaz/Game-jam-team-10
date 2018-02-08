require 'gosu'
load 'Player.rb'

class Enemy < Player

  attr_reader :x, :y, :race, :speed
  attr_accessor :active

  def initialize(x, y, race, boss = false)
    super(x, y, race)
    if boss && race == "Infested"
      @image = Gosu::Image.new("assets/Characters/Infested/Boss.png", :tileable => true)
    elsif boss && race == "Robot"
      @image = Gosu::Image.new("assets/Characters/Infested/boss.png", :tileable => true)
    elsif race == "Robot"
      @image = Gosu::Image.new("assets/Characters/Robots/" + ["notnicerobot.png"].shuffle!.first, :tileable => true)
    end
  end

  def ai(targets)
    target = rand(targets.size)
    targets[target].shield -= rand(16)+7*targets[target].level
    if targets[target].shield < 0
      if targets[target].shield + targets[target].phy_def > 0
        targets[target].health -= 1
      else
        targets[target].health += targets[target].shield + targets[target].phy_def
      end
    end
    @active = false
  end

  def update
    if @health <= 0
      @health = 0
      @shield = 0
      @color = Gosu::Color::GRAY
    end
    if @shield <= 0
      @shield = 0
    end
  end
  def changePos(x)
    @x = x
  end

  def draw
    @image.draw(@x,@y,1, 1, 1, @color)
    if @race != "Infested"
      Gosu.draw_rect(x+90, y+300, 100, 10, Gosu::Color::BLACK, 0)
      Gosu.draw_rect(x+90, y+300, (@shield *100)/@maxShield, 10, Gosu::Color::CYAN, 0)
    end
    Gosu.draw_rect(x+90, y+315, 100, 10, Gosu::Color::BLACK, 0)
    Gosu.draw_rect(x+90, y+315, (@health *100)/@maxHealth, 10, Gosu::Color::GREEN, 0)
  end

  def isClicked?(x, y, xx)
    if (x >= @x-xx+600) && (y >= 230)
      if (x <= @x-xx+790) && (y <= 530)
        return true
      else
        return false
      end
    end
  end

end
