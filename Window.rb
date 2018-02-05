require 'gosu'
load 'Map.rb'

class Game < Gosu::Window

  def initialize(width, height)
    super(width, height)
    self.caption = "Rogue-like"
    @map = Map.new("assets/test.png")
  end

  def update
  end

  def draw
    #@player.draw()
    @map.draw()
  end

end
