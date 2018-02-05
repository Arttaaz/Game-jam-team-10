require 'gosu'


class Map

  #attr_reader :tilemap

  def initialize(tileset)
    @tileset = Gosu::Image.load_tiles(tileset, 1600, 450, :tileable => true)
    @tilemap = [0, 1]
  end

  def generate
  end

  def draw
    size = @tilemap.size
    x=0
    size.times do |i|
      @tileset[i].draw(x*1200, 0, 0)
       x = x+1
    end
  end

end
