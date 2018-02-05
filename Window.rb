require 'gosu'
load 'Map.rb'

class Window < Gosu::Window

  def initialize(width, height)
    super(width, height)
    self.caption = "Rogue-like"
    @map = Map.new("assets/test.png")
    @camera_x = @camera_y = 0
  end

  def update

  end

  def draw

    @camera_x -= 5 if Gosu.button_down? Gosu::KB_LEFT
    @camera_x += 5 if Gosu.button_down? Gosu::KB_RIGHT

    Gosu.translate(-@camera_x, -@camera_y) do
      @map.draw()
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
