
module Type
  PASSIVE = 0
  ACTIVE  = 1
end

class Skill

  attr_reader :name

  def initialize(name, type, target, duration = 0)
    @name = name
    @type = type
    @duration = duration
  end

  def update
  end

end

class LifeModifier < Skill

  def initialize(name, type, target, modifier, duration = 0)
    super(name, type, target, duration)
    @modifier = modifier
    @target = target
  end

  def activate
    @target.health = @target.health + @modifier
    if @type == Type::PASSIVE
      @target.maxHealth = @target.maxHealth + @modifier
    end
  end

  def update
    if @duration != 0
      self.activate
      @duration = @duration - 1
    end
  end

end
