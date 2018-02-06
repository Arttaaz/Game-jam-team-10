require 'gosu'

module Direction
  LEFT,RIGHT = *0..1
end

class Map

  #attr_reader :tilemap

  def initialize(tileset)
    @TILEWIDTH = 1200
    @TILEHEIGHT = 900
    @tileset = Gosu::Image.load_tiles(tileset, @TILEWIDTH, @TILEHEIGHT, :tileable => true)
    @tilemap = [[1, 1, 0], [1, 1, 0], [1, 1, 0]]
    @WIDTH = @tilemap.size
    @HEIGHT = @tilemap[0].size
  end

  def generate
  end

  def move?(xleft, xright,y,dir)
    puts xleft
    case(dir)
    when Direction::LEFT
      if ((xleft*1200-100)/1200 == 0)
        return false
      elsif  xleft-1 > 0
        if (((xleft-1)*1200) < xleft*1200)
          return true
        else
          return false
        end
      else
        return true
      end
    when Direction::RIGHT
      if ((xright*@TILEWIDTH+200)/1200 == @WIDTH)
        return false
      elsif (xright+1 < @WIDTH - 1)
        if (((xright+1)*1200) > (xright*1200))
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
        if tile != 0
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
