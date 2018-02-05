require 'gosu'
load 'Map.rb'
load 'Player.rb'

class Window < Gosu::Window

  def initialize(width, height)
    super(width, height)
    self.caption = "Rogue-like"
    @map = Map.new("assets/test.png")
    @player = Player.new("assets/testchar.png",200,300)
    @camera_x = @camera_y = 0
  end

  def update
    @camera_x -= 5 if Gosu.button_down? Gosu::KB_LEFT
    @camera_x += 5 if Gosu.button_down? Gosu::KB_RIGHT
  end

  def draw
    Gosu.translate(-@camera_x, -@camera_y) do
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
