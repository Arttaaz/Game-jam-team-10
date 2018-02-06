require 'gosu'

module Direction
  LEFT,RIGHT = *0..1
end

class Map

  attr_reader :tilemap

  def initialize(tileset)
    @TILEWIDTH = 1200
    @TILEHEIGHT = 600
    @tileset = Gosu::Image.load_tiles(tileset, @TILEWIDTH, @TILEHEIGHT, :tileable => true)
    @tilemap = [[], [], [], [], [], [], [], [], []]
    self.generate
    @WIDTH = @tilemap.size
    @HEIGHT = @tilemap[0].size

  end

  def generate
    2.times { |y|
      theme = ["medbay", "recreation"].shuffle
      t = theme.pop
      case(t)
      when "medbay"
        l = 5 - rand(3)
      when "recreation"
        l = 3 - rand(4)
      end
      l = l + (2-y)
      puts l
      9.times { |x|
        if l > 0
          @tilemap[x][y] = 0
          l = l-1
        else
          case(t)
          when "medbay"
            @tilemap[x][y] = 3+rand(1)
          when "recreation"
            @tilemap[x][y] = 3+rand(1)
          end
        end
      }
    }

    9.times { |x|
      if x < 5
        @tilemap[x][2] = 0
      else
        @tilemap[x][2] = 1+rand(1)
      end
    }

  end

  def move?(xleft, xright,y,dir)
    y = y+0.5
    case(dir)
    when Direction::LEFT
      if ((xleft*1200-100)/1200 == 0)
        return false
      elsif  xleft-1 > 0
        if @tilemap[xleft-1][y] == 0
          if (((xleft-1).to_i*1200+1200) < (xleft*1200-100).to_i)
            return true
          else
            return false
          end
        else
          return true
        end
      else
        return true
      end
    when Direction::RIGHT
      if ((xright*@TILEWIDTH+200)/1200 == @WIDTH)
        return false
      elsif (xright+1 < @WIDTH - 1)
        if @tilemap[xright+1][y] == 0
          if (((xright+1).to_i*1200) > ((xleft.to_i+1)*1200).to_i)
            return true
          else
            return false
          end
        else
          return true
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
        @tileset[tile].draw(x * @TILEWIDTH, y * @TILEHEIGHT, 0)
      end
    end
  end

end
