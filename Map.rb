require 'gosu'


class Map

  @tilemap

  def initialize(tileset)
    @tileset = Gosu::Image.load_tiles(tileset)
  end

  def generate
  end

end
