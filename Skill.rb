
module Type
  PASSIVE = 0
  ACTIVE  = 1
end

module ActionType
  BUFF   = 0
  DEBUFF = 1
  ATTACK = 2
end

module Effect
  LIFE    = 0
  SHIELD  = 1
  POWER   = 2
  POW_REN = 3
  PHY_DMG = 4
  ENG_DMG = 5
  PHY_DEF = 6
  ENG_DEF = 7
  SPEED   = 8
end

module Who
  SELF     = 0
  ALLY     = 1
  ALLIES   = 2
  ENNEMY   = 3
  ENNEMIES = 4
end

class Skill

  attr_reader :type, :action, :effect, :who, :modifier

  def initialize(type, action, effect, who, modifier)
    @type = type
    @action = action
    @effect = effect
    @who = who
    @modifier = modifier
  end

end
