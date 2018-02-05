require 'gosu'
load 'Map.rb'
load 'Player.rb'

module Direction
  UP,RIGHT,DOWN,LEFT = *0..3
end

class Window < Gosu::Window

  def initialize(width, height)
    super(width, height)
    self.caption = "Rogue-like"
    @map = Map.new("assets/test.png")
    @player = Player.new("assets/testchar.png",200,300)
    @camera_x = @camera_y = 0
  end

  def update

    if (Gosu.button_down? Gosu::KB_LEFT)
      if (@map.move?(@player.x/1200, @player.y/900, Direction::LEFT))
        @player.move(-5,0)
      end
    elsif (Gosu.button_down? Gosu::KB_RIGHT)
      if(@map.move?(@player.x/1200, @player.y/900, Direction::RIGHT))
        @player.move(5,0)
      end
    end
  end

  def draw
    Gosu.translate(-@player.x+200, -@player.y+300) do
      @map.draw()
      @player.draw()
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
