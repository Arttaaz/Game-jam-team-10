
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

class Skill

  attr_reader :name, :type, :target
  attr_accessor :target

  def initialize(name, type, who, modifier, duration = 0, temp = false, cost = 0, target = nil)
    @name = name
    @type = type
    @target = target
    @modifier = modifier
    @duration = duration
    @temp = temp
    @cost = cost
    @activated = false
  end

  def activate
    @activated = true
    return @cost
  end

  def update
    if @duration != 0
      self.activate
      @duration = @duration - 1
    elsif temp == true && @activated == true
      @modifier = -@modifier
      self.activate
      @activated = false
    end
  end

  def isClicked?(x, y, xx)
    if (x >= @x+xx) && (y >= @y+yy)
      if (x <= @x+xx+@width) && (y <= @y+yy+@height)
        return true
      else
        return false
      end
    end
  end

end

class HealthModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, target = nil)
    super(name, type, target, modifier, duration, cost)
  end

  def activate
    healthCheck = @target.health + (@target.health * @modifier)/100
    if healthCheck > @target.maxHealth
      @target.health = @target.maxHealth
    elsif healthCheck < 0
      @target.health = 0
    else
      @target.health = healthCheck
    end
    super
  end
end

class MaxHealthModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, target = nil)
    super(name, type, target, modifier, duration, temp, cost)
  end

  def activate
    maxHealthCheck = @target.maxHealth + (@target.maxHealth * @modifier)/100
    if maxHealthCheck < 0
      @target.maxHealth = 0
    else
      @target.maxHealth = maxHealthCheck
    end
    super
  end
end

class PowerModif< Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, target = nil)
    super(name, type, target, modifier, duration, cost)
  end

  def activate
    powerCheck = @target.power + (@target.power * @modifier)/100
    if powerCheck > @target.maxPower
      @target.power = @target.maxPower
    elsif powerCheck < 0
      @target.power = 0
    else
      @target.power = powerCheck
    end
    super
  end
end

class MaxPowerModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, target = nil)
    super(name, type, target, modifier, duration, temp, cost)
  end

  def activite
    maxPowerCheck = @target.maxPower + (@target.maxPower * @modifier)/100
    if maxPowerCheck < 0
      @target.maxPower = 0
    else
      @target.maxPower = maxPowerCheck
    end
    super
  end
end

class DmgModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, target = nil)
    super(name, type, target, modifier, duration, temp, cost)
  end

  def activate
    @target.damage = @target.damage + (@target.damage * @modifier)/100
    super
  end
end

class DmgReducModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, target = nil)
    super(name, type, target, modifier, duration, temp, cost)
  end

  def activate
    dmgReducCheck = @target.dmgReduc + (@target.dmgReduc * @modifier)/100
    if dmgReduc > 100
      @target.dmgReduc = 100
    else
      @target.dmgReduc = dmgReducCheck
    end
    super
  end
end

class PowerRegenModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, target = nil)
    super(name, type, target, modifier, duration, temp, cost)
  end

  def activate
    @target.powRegen = @target.powRegen + (@target.powerRegen * @modifier)/100
    super
  end
end

class ResModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, target = nil)
    super(name, type, target, modifier, duration, temp, cost)
  end

  def activate
    @target.phy_def = @target.phy_def + (@target.phy_def * @modifier)/100
    @target.eng_def = @target.eng_def + (@target.eng_def * @modifier)/100
    super
  end
end

class PhysDefModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, target = nil)
    super(name, type, target, modifier, duration, temp, cost)
  end

  def activate
    @target.phy_def = @target.phy_def + (@target.phy_def * @modifier)/100
    super
  end
end

class EngDefModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, target = nil)
    super(name, type, target, modifier, duration, temp, cost)
  end

  def activate
    @target.eng_def = @target.eng_def + (@target.eng_def * @modifier)/100
    super
  end
end

class ExpModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, target = nil)
    super(name, type, target, modifier, duration, temp, cost)
  end

  def activate
    @target.expBonus = @target.expBonus + (@target.expBonus * @modifier)/100
    super
  end
end

class SpeedModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, target = nil)
    super(name, type, target, modifier, duration, temp, cost)
  end

  def activate
    @target.speed = @target.speed + @modifier
    super
  end
end

class ShieldModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, target = nil)
    super(name, type, target, modifier, duration, temp, cost)
  end

  def activate
    shieldCheck = @target.shield + (@target.shield * @modifier)/100
    if shieldCheck > @target.maxShield
      @target.shield = @target.maxShield
    elsif shield < 0
      @target.shield = 0
    else
      @target.shield = shieldCheck
    end
    super
  end
end

class MaxShieldModif < Skill
  def initialize(name, type, who, modifier, image, cost = 0, duration = 0, temp = false, target = nil)
    super(name, type, target, modifier, duration, temp, cost)
  end

  def activiate
    maxShieldCheck = @target.maxShield + (@target.maxShield * @modifier)/100
    if maxShieldCheck < 0
      @target.maxShield = 0
    else
      @target.maxShield = maxShieldCheck
    end
    super
  end
end
