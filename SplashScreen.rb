require 'gosu'

class SplashScreen

  def initialize(image, message)
    @image = image
    @message = message
    @duree = 180
  end

  def update
    if @duree > 0
      @duree -= 1
    end
  end

  def draw(x, y)
    if @duree > 0
      Gosu.draw_rect()
      @image.draw(x, y, 5)
    end
  end

end
