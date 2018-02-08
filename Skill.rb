require 'gosu'

module Type
  PASSIVE = 0
  ACTIVE  = 1
end

module Who
  SELF = 0
  ALLY = 1
  ALLIES = 2
  ENEMY = 3
  ENEMIES = 4
end

module DmgType
  PHYS = 0
  ENG = 1
end

class Skill

  attr_reader :name, :type, :target, :who
  attr_accessor :target, :color

  def initialize(name, type, who, modifier, image, options = { cost: 0, duration: 0, temp: false, dmgType: nil, target: nil })
    @name = name
    @image = Gosu::Image.new(image, :tileable => true)
    @type = type
    @x = 0
    @y = 0
    @target = options[:target]
    @modifier = modifier
    @duration = options[:duration]
    @temp = options[:temp]
    @cost = options[:cost]
    @activated = false
    @who = who
    @dmgType = options[:dmgType]
    @color = 0xff_ffffff
  end

  def activate(caster)
    @activated = true
    return @cost
  end

  def update
    if @duration != 0 && @activated == true
      self.activate(@caster)
      @duration = @duration - 1
    elsif @temp == true && @activated == true
      @modifier = -@modifier
      self.activate(@caster)
      @activated = false
    end
  end

  def draw(x, y)
    @x = x
    @y = y
    @image.draw(x, y, 1, 1, 1, @color)
  end

  def isClicked?(x, y, xx, yy) #xx is x camera translation yy is y camera translation    if (x >= @x+xx) && (y >= @y+yy)
    if (x >= @x+xx) && (y >= @y+yy)
      if (x <= @x+xx+60) && (y <= @y+yy+60)
        return true
      else
        return false
      end
    end
  end

end

class Heal < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, dmgType = nil, target = nil)
    super(name, type, who, modifier, image, :cost => cost, :duration => duration, :target => target)
  end

  def activate(caster)
    @caster = caster
    if @who == Who::ALLIES || @who == Who::ENEMIES
      @target.each { |t|
        healCheck = t.health + (@caster.damage * @modifier)/100
        if healCheck > t.maxHealth
          t.health = t.maxHealth
        elsif healCheck < 0
          t.health = 0
        else
          t.health = healCheck
        end
      }
    else
      healCheck = @target.health + (@caster.damage * @modifier)/100
      if healCheck > @target.maxHealth
        @target.health = @target.maxHealth
      elsif healCheck < 0
        @target.health = 0
      else
        @target.health = healCheck
      end
    end
    super
  end
end

class Dmg < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, dmgType = nil, target = nil)
    super(name, type, who, modifier, image, :cost => cost, :duration => duration, :target => target, :dmgType => dmgType)
  end

  def activate(caster)
    @caster = caster
    if @who == Who::ALLIES || @who == Who::ENEMIES
      @target.each { |t|
        if (t.shield == 0)
          if (@dmgType == 0)
            t.health = (t.health - ((((@caster.damage * @modifier)/100) * ((100 - t.dmgReduc)/100)) - t.phy_def))
          else
            t.health = (t.health - ((((@caster.damage * @modifier)/100) * ((100 - t.dmgReduc)/100)) - t.eng_def))
          end
        else
          t.shield = (t.shield - ((@caster.damage * @modifier)/100) * ((100 - t.dmgReduc)/100))
          if t.shield < 0
            if @dmgType == 0
              t.health += t.shield - t.phy_def
            else
              t.health += t.shield - t.eng_def
            end
          end
        end
      }
    else
      if (@target.shield == 0)
        if (@dmgType == 0)
          @target.health = (@target.health - ((((@caster.damage * @modifier)/100) * ((100 - @target.dmgReduc)/100)) - @target.phy_def))
        else
          @target.health = (@target.health - ((((@caster.damage * @modifier)/100) * ((100 - @target.dmgReduc)/100)) - @target.eng_def))
        end
      else
        @target.shield = (@target.shield - ((@caster.damage * @modifier)/100) * ((100 - @target.dmgReduc)/100))
        if @target.shield < 0
          if @dmgType == 0
            @target.health += @target.shield - @target.phy_def
          else
            @target.health += @target.shield - @target.eng_def
          end
        end
      end
    end
    super
  end
end


class MaxHealthModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, dmgType = nil, target = nil)
    super(name, type, who, modifier, image, :duration => duration, :temp => temp, :cost => cost, :target => target)
  end

  def activate(caster)
    @caster = caster
    if @who == Who::ALLIES || @who == Who::ENEMIES
      @target.each { |t|
        maxHealthCheck = t.maxHealth + (t.maxHealth * @modifier)/100
        if maxHealthCheck < 0
          t.maxHealth = 0
        else
          t.maxHealth = maxHealthCheck
        end
      }
    else
      maxHealthCheck = @target.maxHealth + (@target.maxHealth * @modifier)/100
      if maxHealthCheck < 0
        @target.maxHealth = 0
      else
        @target.maxHealth = maxHealthCheck
      end
    end
    super
  end
end

class PowerModif< Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, dmgType = nil, target = nil)
    super(name, type, who, modifier, image, :cost => cost, :duration => duration, :target => target)
  end

  def activate(caster)
    @caster = caster
    if @who == Who::ALLIES || @who == Who::ENEMIES
      @target.each { |t|
        powerCheck = t.power + (t.power * @modifier)/100
        if powerCheck > t.maxPower
          t.power = t.maxPower
        elsif powerCheck < 0
          t.power = 0
        else
          t.power = powerCheck
        end
      }
    else
      powerCheck = @target.power + (@target.power * @modifier)/100
      if powerCheck > @target.maxPower
        @target.power = @target.maxPower
      elsif powerCheck < 0
        @target.power = 0
      else
        @target.power = powerCheck
      end
    end
    super
  end
end

class MaxPowerModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, dmgType = nil, target = nil)
    super(name, type, who, modifier, image, :duration => duration, :temp =>temp, :cost =>cost, :target =>target)
  end

  def activite(caster)
    @caster = caster
    if @who == Who::ALLIES || @who == Who::ENEMIES
      @target.each { |t|
        maxPowerCheck = t.maxPower + (t.maxPower * @modifier)/100
        if maxPowerCheck < 0
          t.maxPower = 0
        else
          t.maxPower = maxPowerCheck
        end
      }
    else
      maxPowerCheck = @target.maxPower + (@target.maxPower * @modifier)/100
      if maxPowerCheck < 0
        @target.maxPower = 0
      else
        @target.maxPower = maxPowerCheck
      end
    end
    super
  end
end

class DmgModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, dmgType = nil, target = nil)
    super(name, type, who, modifier, image, :duration => duration, :temp =>temp, :cost =>cost, :target =>target)
  end

  def activate(caster)
    @caster = caster
    if @who == Who::ALLIES || @who == Who::ENEMIES
      @target.each { |t|
          t.damage = t.damage + (t.damage * @modifier)/100
      }
    else
      @target.damage = @target.damage + (@target.damage * @modifier)/100
    end
    super
  end
end

class DmgReducModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, dmgType = nil, target = nil)
    super(name, type, who, modifier, image, :duration => duration, :temp => temp, :cost => cost, :target => target)
  end

  def activate(caster)
    @caster = caster
    if @who == Who::ALLIES || @who == Who::ENEMIES
      @target.each { |t|
        dmgReducCheck = t.dmgReduc + (t.dmgReduc * @modifier)/100
        if dmgReduc > 100
          t.dmgReduc = 100
        else
          t.dmgReduc = dmgReducCheck
        end
      }
    else
      dmgReducCheck = @target.dmgReduc + (@target.dmgReduc * @modifier)/100
      if dmgReduc > 100
        @target.dmgReduc = 100
      else
        @target.dmgReduc = dmgReducCheck
      end
    end
    super
  end
end

class PowerRegenModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, dmgType = nil, target = nil)
    super(name, type, who, modifier, image, :duration => duration, :temp => temp, :cost => cost, :target => target)
  end

  def activate(caster)
    @caster = caster
    if @who == Who::ALLIES || @who == Who::ENEMIES
      @target.each { |t|
        t.powRegen = t.powRegen + (t.powerRegen * @modifier)/100
      }
    else
      @target.powRegen = @target.powRegen + (@target.powerRegen * @modifier)/100
    end
    super
  end
end

class ResModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, dmgType = nil, target = nil)
    super(name, type, who, modifier, image, :duration => duration, :temp => temp, :cost => cost, :target => target)
  end

  def activate(caster)
    @caster = caster
    if @who == Who::ALLIES || @who == Who::ENEMIES
      @target.each { |t|
        t.phy_def = t.phy_def + (t.phy_def * @modifier)/100
        t.eng_def = t.eng_def + (t.eng_def * @modifier)/100
      }
    else
      @target.phy_def = @target.phy_def + (@target.phy_def * @modifier)/100
      @target.eng_def = @target.eng_def + (@target.eng_def * @modifier)/100
    end
    super
  end
end

class PhysDefModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, dmgType = nil, target = nil)
    super(name, type, who, modifier, image, :duration => duration, :temp => temp, :cost => cost, :target => target)
  end

  def activate(caster)
    @caster = caster
    if @who == Who::ALLIES || @who == Who::ENEMIES
      @target.each { |t|
        t.phy_def = t.phy_def + (t.phy_def * @modifier)/100
      }
    else
      @target.phy_def = @target.phy_def + (@target.phy_def * @modifier)/100
    end
    super
  end
end

class EngDefModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, dmgType = nil, target = nil)
    super(name, type, who, modifier, image, :duration => duration, :temp => temp, :cost => cost, :target => target)
  end

  def activate(caster)
    @caster = caster
    if @who == Who::ALLIES || @who == Who::ENEMIES
      @target.each { |t|
        t.eng_def = t.eng_def + (t.eng_def * @modifier)/100
      }
    else
      @target.eng_def = @target.eng_def + (@target.eng_def * @modifier)/100
    end
    super
  end
end

class ExpModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, dmgType = nil, target = nil)
    super(name, type, who, modifier, image, :duration => duration, :temp => temp, :cost => cost, :target => target)
  end

  def activate(caster)
    @caster = caster
    if @who == Who::ALLIES || @who == Who::ENEMIES
      @target.each { |t|
        t.expBonus = t.expBonus + (t.expBonus * @modifier)/100
      }
    else
      @target.expBonus = @target.expBonus + (@target.expBonus * @modifier)/100
    end
    super
  end
end

class SpeedModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, dmgType = nil, target = nil)
    super(name, type, who, modifier, image, :duration => duration, :temp => temp, :cost => cost, :target => target)
  end

  def activate(caster)
    @caster = caster
    if @who == Who::ALLIES || @who == Who::ENEMIES
      @target.each { |t|
        t.speed = t.speed + @modifier
      }
    else
      @target.speed = @target.speed + @modifier
    end
    super
  end
end

class ShieldModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, dmgType = nil, target = nil)
    super(name, type, who, modifier, image, :duration => duration, :temp => temp, :cost => cost, :target => target)
  end

  def activate(caster)
    @caster = caster
    if @who == Who::ALLIES || @who == Who::ENEMIES
      @target.each { |t|
        shieldCheck = t.shield + (t.shield * @modifier)/100
        if shieldCheck > t.maxShield
          t.shield = t.maxShield
        elsif shield < 0
          t.shield = 0
        else
          t.shield = shieldCheck
        end
      }
    else
      shieldCheck = @target.shield + (@target.shield * @modifier)/100
      if shieldCheck > @target.maxShield
        @target.shield = @target.maxShield
      elsif shield < 0
        @target.shield = 0
      else
        @target.shield = shieldCheck
      end
    end
    super
  end
end

class MaxShieldModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, dmgType = nil, target = nil)
    super(name, type, who, modifier, image, :duration => duration, :temp => temp, :cost => cost, :target => target)
  end

  def activiate(caster)
    @caster = caster
    if @who == Who::ALLIES || @who == Who::ENEMIES
      @target.each { |t|
        maxShieldCheck = t.maxShield + (t.maxShield * @modifier)/100
        if maxShieldCheck < 0
          t.maxShield = 0
        else
          t.maxShield = maxShieldCheck
        end
      }
    else
      maxShieldCheck = @target.maxShield + (@target.maxShield * @modifier)/100
      if maxShieldCheck < 0
        @target.maxShield = 0
      else
        @target.maxShield = maxShieldCheck
      end
    end
    super
  end
end
