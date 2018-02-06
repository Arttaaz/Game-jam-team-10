require 'gosu'
load 'Map.rb'
load 'Player.rb'
load 'IHM.rb'

class Window < Gosu::Window

  def initialize(width, height)
    super(width, height)
    self.caption = "Rogue-like"
    @map = Map.new("assets/TileSet.png")
    @xStart = 100+4*1200
    @yStart = 150+ 2*600
    @players = [Player.new("assets/testchar.png",@xStart,@yStart), Player.new('assets/testchar.png', @xStart+150, @yStart), Player.new('assets/testchar.png', @xStart+300, @yStart)]
    @ihm = IHM.new(@players[0].x-100,@players[0].y-150)
  end

  def update
    if (Gosu.button_down? Gosu::KB_LEFT)
      if (@map.move?(@players[0].x/1200.0, @players.last.x/1200.0, @players[0].y/900.0, Direction::LEFT))
        @players.each { |p| p.move(-5,0) }
      end
    elsif (Gosu.button_down? Gosu::KB_RIGHT)
      if(@map.move?(@players[0].x/1200.0, @players.last.x/1200.0, @players[0].y/900.0, Direction::RIGHT))
        @players.each { |p| p.move(5,0) }
      end
    end

    @players.each { |p| p.move(0,-5) } if Gosu.button_down? Gosu::KB_UP
    @players.each { |p| p.move(0,5) } if Gosu.button_down? Gosu::KB_DOWN
    @ihm.update(@players[0].x,@players[0].y)
  end

  def draw
    Gosu.translate(-@players[0].x+100, -@players[0].y+150) do
      @map.draw()
      @players.each { |p| p.draw() }
      Gosu.draw_rect(@players[0].x-100, 600+@players[0].y-150, 1200, 300, Gosu::Color::GRAY, 0)
      @ihm.draw
    end
  end

  def button_down(id)
    case(id)
    when Gosu::KB_ESCAPE
      close
    else
      super
    end
  end

  def needs_cursor?
    true
  end
end
