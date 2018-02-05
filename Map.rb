require 'gosu'


class Map

  #attr_reader :tilemap

  def initialize(tileset)
    @WIDTH = 1200
    @HEIGHT = 900
    @tileset = Gosu::Image.load_tiles(tileset, @WIDTH, @HEIGHT, :tileable => true)
    @tilemap = [[0], [1]]
  end

  def generate
  end

  def move?(x,y,dir)
    case(dir)
    when 0
    when 1
      if ((x*1200+200)/1200 == @tilemap.size)
        return false
      elsif (x+1 < @tilemap.size - 1)
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
    size = @tilemap.size
    x=0
    size.times do |i|
      @tileset[i].draw(x*@WIDTH, 0, 0)
       x = x+1
    end
  end

end
