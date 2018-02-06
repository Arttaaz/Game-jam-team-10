
module Type
  PASSIVE = 0
  ACTIVE  = 1
end

class Skill

  attr_reader :name

  def initialize(name, type)
    @name = name
    @type = type
  end

end

class LifeBuff < Skill

  def initialize(name, type, modifier, target)
    super(name, type)
    @modifier = modifier
    @target = target
  end

  def activate
    @target.health = @target.health + @modifier
    if @type == Type::PASSIVE
      @target.maxHealth = @target.maxealth + @modifier
    end
  end

end
