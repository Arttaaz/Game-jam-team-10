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

  def update(x,y)
    @x = x
    @y = y
  end

  def box
    draw_rect(@x+465,@y+455,610,290,Gosu::Color::BLACK, z=0, :default)
    draw_rect(@x+100,@y+455,70,70,Gosu::Color::WHITE, z=0, :default)
    draw_rect(@x+190,@y+455,70,70,Gosu::Color::WHITE, z=0, :default)
    draw_rect(@x+280,@y+455,70,70,Gosu::Color::WHITE, z=0, :default)
    draw_rect(@x+370,@y+455,70,70,Gosu::Color::WHITE, z=0, :default)

    @font.draw("Human",  @x-90, @y+455, 1, 2.0, 2.0, Gosu::Color::BLUE)
    @font.draw("Soldier",  @x-90, @y+490, 1, 2.0, 2.0, Gosu::Color::BLUE)

    @font.draw("Damage: 35",  @x-90, @y+570, 1, 1.0, 1.0, Gosu::Color::GREEN)
    @font.draw("Physical def: 8",  @x-90, @y+600, 1, 1.0, 1.0, Gosu::Color::GREEN)
    @font.draw("Energy def : 8",  @x-90, @y+630, 1, 1.0, 1.0, Gosu::Color::GREEN)
    @font.draw("Speed : 12",  @x-90, @y+660, 1, 1.0, 1.0, Gosu::Color::GREEN)

    @font.draw("Item list",  @x+200, @y+540, 1, 1.0, 1.0, Gosu::Color::FUCHSIA)

  end


end
