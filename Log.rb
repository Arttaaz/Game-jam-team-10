require 'gosu'

class Log < Gosu::Window

  attr_reader :message

  def initialize(x,y)
    @x = x
    @y = y
    @lignes = ["Bienvenue dans l' Ascension-3 !",
    "Le vaisseau est attaqué, vous devez en reprendre le contrôle !",
    "Rendez vous au cockpit au sommet !",
    " "]
    @font = Gosu::Font.new(20)
  end

  def addLine(message)
    @lignes << message
    if @lignes[19].nil? == false
      @lignes.delete_at(0)
    end
  end

  def update(x,y)
    @x = x
    @y = y
  end

  def dispLog
    d=0
    @lignes.each do |ligne|
      @font.draw(ligne, @x,@y+d, 1,0.8,0.8, Gosu::Color::WHITE)
      d+=15
    end
  end


end
