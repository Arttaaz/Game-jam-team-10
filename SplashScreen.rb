require 'gosu'

class SplashScreen

  attr_reader :image, :message
  attr_accessor :image, :message

  def initialize(image, message)
    @image = image
    @message = Gosu::Image.from_text(message, 10, :width => 460, :align => :center)
    @duree = 0
  end

  def show
    @duree = 180
  end

  def update
    if @duree > 0
      @duree -= 1
    end
  end

  def draw(x, y)
    if @duree > 0
      Gosu.draw_rect(x, y, 500, 300, Gosu::Color::GRAY, 5)
      @image.draw(x+200, y+100, 5)
      @message.draw(x+20, y+80, 5)
    end
  end

end
