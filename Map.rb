require 'gosu'

module Direction
  LEFT, RIGHT, UP, DOWN = *0..3
end

module Event
  ENCOUNTER,LOOT,FRIENDLY = *0..2
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
    maxl = 5
    theme = ["medbay", "recreation", "engine"].shuffle
    3.times { |y|
      t = theme.pop
      case(t)
      when "medbay"
        l = 5 - rand(3)
      when "recreation"
        l = 3 - rand(4)
      when "engine"
        l = 4+rand(3)
      end
      l = l + (y-3)
      if l > 5
        maxl = l
      end
      9.times { |x|
        if l > 0
          @tilemap[x][y+1] = 0
          l -= 1
        else
          case(t)
          when "medbay"
            @tilemap[x][y+1] = 5+rand(2)
          when "recreation"
            @tilemap[x][y+1] = 3+rand(2)
          when "engine"
            @tilemap[x][y+1] = 7+rand(2)
          end
        end
      }
    }

    9.times { |x|
      @tilemap[x][0] = 0
      if x < 5
        @tilemap[x][4] = 0
      else
        @tilemap[x][4] = 1+rand(2)
      end
    }

    a = maxl + rand(4)
    if a >= 8
      a = 7
    end

    5.times { |y|
      @tilemap[a][y] = 9
    }

    @tilemap[a-1][0] = 10

  end

  def move?(xleft, xright,y,dir)
    case(dir)
    when Direction::LEFT
      if ((xleft*1200-100)/1200 == 0)
        return false
      elsif  xleft-1 >= 0
        if @tilemap[xleft-1][y.to_i] == 0
            return false
        else
          return true
        end
      end
    when Direction::RIGHT
      if ((xleft.to_i+1) == @WIDTH)
        return false
      elsif (xright+1 < @WIDTH - 1)
        if @tilemap[xright+1][y.to_i] == 0
          return false
        else
          return true
        end
      else
        return true
      end
    when Direction::UP
      if (tilemap[xleft.to_i][y.to_i] == 9) && (y > 1)
        return true
      else
        return false
      end
    when Direction::DOWN
      if tilemap[xleft.to_i][y.to_i] == 9 && y < 4
        return true
      else
        return false
      end
    end
  end

  def draw
    @HEIGHT.times do |y|
      @WIDTH.times do |x|
        tile = @tilemap[x][y]
        if tile != 0
          @tileset[tile].draw(x * @TILEWIDTH, y * @TILEHEIGHT, 0)
        end
      end
    end
  end

end
