
module Type
  PASSIVE = 0
  ACTIVE  = 1
end

class Skill

  attr_reader :name

  def initialize(name, type, target, modifier, duration = 0)
    @name = name
    @type = type
    @target = target
    @modifier = modifier
    @duration = duration
  end

  def activate
  end

  def update
    if @duration != 0
      self.activate
      @duration = @duration - 1
    elsif @temp == true
      @modifier = -@modifier
      self.activate
    end
  end

end

class LifeModifier < Skill

  def initialize(name, type, target, modifier, duration = 0)
    super(name, type, target, modifier, duration)
  end

  def activate
    if @target.health+@modifier < 0
      @target.health = 0
    else
      @target.health = @target.health + @modifier if ((@modifier+@target.health) < (@target.maxHealth)) && (@modifier+@target.health >= 0)
    end
    if @type == Type::PASSIVE
      @target.maxHealth = @target.maxHealth + @modifier
    end
  end

end

class PowerModifier < Skill

  def initialize(name, type, target, modifier, duration = 0)
    super(name, type, target, modifier, duration)
  end

  def activate
    @target.power = @target.power + @modifier
    if @type == Type::PASSIVE
      @target.maxPower = @targer.maxPower + @modifier
    end
  end
end
