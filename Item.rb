require 'gosu'
load 'Player.rb'


class Item

  attr_reader :name

  def initialize(name, image)
    @name = name
    @image = image
    @color = 0xff_ffffff
  end

  def draw(x, y)
    @image.draw(x, y, 1, 1, 1, @color)
  end

  def isClicked?(x, y, xx,yy)
    if (x >= @x+xx) && (y >= @y+yy)
      if (x <= @x+xx+@width) && (y <= @y+yy+@height)
        return true
      else
        return false
      end
    end
  end


end

=begin
quand obtient objet l'ajouter aux objets du négro

=end
