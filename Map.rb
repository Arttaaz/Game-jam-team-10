require 'gosu'


class Map

  def initialize(tileset)
    @tileset = Gosu::Image.load_tiles(tileset)
  end

end
