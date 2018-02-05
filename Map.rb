require 'gosu'


class Map

  attr_accessor :tilemap

  @tilemap = [0, 1]

  def initialize(tileset)
    @tileset = Gosu::Image.load_tiles(tileset, 1600, 900)
  end

  def generate
  end

  def draw
    @tilemap.size().times do |i|
      x = 0
      @tileset[i].draw(x*1600, 0)
      x = x+1
    end
  end

end
