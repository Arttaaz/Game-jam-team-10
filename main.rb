require 'gosu'


class Game < Gosu::Window

  def initialize
    super(800,800)
    self.caption = "Rogue-like"
  end

  def update
  end

  def draw
  end

end
Game.new.show()
