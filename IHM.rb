require 'gosu'


class IHM < Gosu::Window

  def initialize(x,y)
    @x = x
    @y = y
    @font = Gosu::Font.new(20)
  end

  def draw
    self.box
  end

  def box
=begin
    draw_rect(560,605,610,290,Gosu::Color::BLACK, z=0, :default)
    draw_rect(200,605,70,70,Gosu::Color::WHITE, z=0, :default)
    draw_rect(290,605,70,70,Gosu::Color::WHITE, z=0, :default)
    draw_rect(380,605,70,70,Gosu::Color::WHITE, z=0, :default)
    draw_rect(470,605,70,70,Gosu::Color::WHITE, z=0, :default)

    @font.draw("Human",  10, 605, 1, 2.0, 2.0, Gosu::Color::BLUE)
    @font.draw("Soldier",  10, 640, 1, 2.0, 2.0, Gosu::Color::BLUE)

    @font.draw("Damage: 35",  10, 720, 1, 1.0, 1.0, Gosu::Color::GREEN)
    @font.draw("Physical def: 8",  10, 750, 1, 1.0, 1.0, Gosu::Color::GREEN)
    @font.draw("Energy def : 8",  10, 780, 1, 1.0, 1.0, Gosu::Color::GREEN)
    @font.draw("Speed : 12",  10, 810, 1, 1.0, 1.0, Gosu::Color::GREEN)

    @font.draw("Item list",  300, 690, 1, 1.0, 1.0, Gosu::Color::FUCHSIA)
=end

    draw_rect(560,605,610,290,Gosu::Color::BLACK, z=0, :default)
    draw_rect(200,605,70,70,Gosu::Color::WHITE, z=0, :default)
    draw_rect(290,605,70,70,Gosu::Color::WHITE, z=0, :default)
    draw_rect(380,605,70,70,Gosu::Color::WHITE, z=0, :default)
    draw_rect(470,605,70,70,Gosu::Color::WHITE, z=0, :default)

    @font.draw("Human",  -@x, -@y, 1, 2.0, 2.0, Gosu::Color::BLUE)
    @font.draw("Soldier",  10, 640, 1, 2.0, 2.0, Gosu::Color::BLUE)

    @font.draw("Damage: 35",  10, 720, 1, 1.0, 1.0, Gosu::Color::GREEN)
    @font.draw("Physical def: 8",  10, 750, 1, 1.0, 1.0, Gosu::Color::GREEN)
    @font.draw("Energy def : 8",  10, 780, 1, 1.0, 1.0, Gosu::Color::GREEN)
    @font.draw("Speed : 12",  10, 810, 1, 1.0, 1.0, Gosu::Color::GREEN)

    @font.draw("Item list",  300, 690, 1, 1.0, 1.0, Gosu::Color::FUCHSIA)

  end


end

# mettre @players dans variables x,y
# pour les utiliser dans les fonctions draw d'IHM
