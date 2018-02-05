require 'gosu'


class Map

  #attr_reader :tilemap

  def initialize(tileset)
    @TILEWIDTH = 1200
    @TILEHEIGHT = 900
    @tileset = Gosu::Image.load_tiles(tileset, @TILEWIDTH, @TILEHEIGHT, :tileable => true)
    @tilemap = [[0, 1], [1, 0]]
    @WIDTH = @tilemap.size
    @HEIGHT = @tilemap[0].size
  end

  def generate
  end

  def move?(x,y,dir)
    case(dir)
    when 0
    when 1
      if ((x*1200+200)/1200 == @WIDTH)
        return false
      elsif (x+1 < @WIDTH - 1)
        if (((x+1)*1200) > (x*1200))
          return true
        else
          return false
        end
      else
        return true
      end

    when 2
    when 3
      if (x == 0)
        return false
      elsif  x-1 > 0
        if (((x-1)*1200) < x*1200)
          return true
        else
          return false
        end
      else
        return true
      end
    end
  end

  def draw

    @HEIGHT.times do |y|
      @WIDTH.times do |x|
        tile = @tilemap[x][y]
        if tile
          # Draw the tile with an offset (tile images have some overlap)
          # Scrolling is implemented here just as in the game objects.
          @tileset[tile].draw(x * @TILEWIDTH, y * @TILEHEIGHT, 0)
        end
      end
    end

    #size = @tilemap.size
    #x=0
    #size.times do |i|
    #  @tileset[i].draw(x*@WIDTH, 0, 0)
    #   x = x+1
  end

end
