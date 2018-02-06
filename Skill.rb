
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
    end
  end

end

class LifeModifier < Skill

  def initialize(name, type, target, modifier, duration = 0)
    super(name, type, target, modifier, duration)
  end

  def activate
    @target.health = @target.health + @modifier
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
