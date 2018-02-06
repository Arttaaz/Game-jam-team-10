require 'gosu'
load 'Map.rb'
load 'Player.rb'
load 'Enemy.rb'
load 'IHM.rb'
load 'Skill.rb'

class Window < Gosu::Window

  def initialize(width, height)
    super(width, height)
    self.caption = "Rogue-like"
    @map = Map.new("assets/TileSet.png")
    @xStart = 100+8*1200
    @yStart = 250+ 2*600
    @players = [Player.new("assets/testchar.png",@xStart,@yStart), Player.new('assets/testchar.png', @xStart+150, @yStart), Player.new('assets/testchar.png', @xStart+300, @yStart)]
    @enemies = []
    @ihm = IHM.new(@players[0].x-100,@players[0].y-250,@players[0])
    @fighting = false
    @moveRight = @moveLeft = false
    @newTile = false

    @enemyRace = ["Human", "Robot", "Infested"].shuffle.first
    case @enemyRace
    when "Human"
    when "Robot"
    when "Infested"
    end

    @enemiesImages = [ "assets/autreAlien.png" ]

  end

  def update
    if @fighting == false #if not in a fight
      if @players[0].vel_x == 0 #if not moving
        if @newTile == true
          self.event
        end
        if (@map.move?(@players[0].x/1200.0, @players.last.x/1200.0, @players[0].y/900.0, Direction::LEFT))
          @moveLeft = true
        else
          @moveLeft = false
        end

        if(@map.move?(@players[0].x/1200.0, @players.last.x/1200.0, @players[0].y/900.0, Direction::RIGHT))
          @moveRight = true
        else
          @moveRight = false
        end

        @players.each { |p| p.move(0,-5) } if Gosu.button_down? Gosu::KB_UP
        @players.each { |p| p.move(0,5) } if Gosu.button_down? Gosu::KB_DOWN
      else
        @moveLeft = @moveRight = false
      end
    else
      @moveLeft = @moveRight = false


      @enemies.each { |e| e.update() }
    end
    @players.each { |p| p.update() }
    @ihm.update(@players[0].x,@players[0].y)

  end

  def draw
    Gosu.translate(-@players[0].x+100, -@players[0].y+250) do
      @map.draw()
      @players.each { |p| p.draw() }
      Gosu.draw_rect(@players[0].x-100, 600+@players[0].y-250, 1200, 300, Gosu::Color::GRAY, 0)
      @ihm.draw
      if @moveLeft
        Gosu::Image.new("assets/testarrow.png", :tileable => true).draw(@players[0].x-30, @players[0].y, 2, -1)
      end
      if @moveRight
        Gosu::Image.new("assets/testarrow.png", :tileable => true).draw(@players[0].x+1000, @players[0].y, 2)
      end
      if @fighting == true
        @enemies.each { |e| e.draw() }
      end
    end
  end

  def button_down(id)
    case(id)
    when Gosu::KB_ESCAPE
      close
    when Gosu::MS_LEFT
      @ihm.click(self.mouse_x, self.mouse_y, -@players[0].x+100, -@players[0].y+150)
      if @moveLeft && self.mouse_x >= 30 && self.mouse_x <= 80
        if self.mouse_y >= 150 && self.mouse_y <= 450
          @players.each { |p| p.vel_x = -5 }
          @newTile = true
        end
      elsif @moveRight && self.mouse_x >= 1100 && self.mouse_x <= 1150
        if self.mouse_y >= 150 && self.mouse_y <= 450
          @players.each { |p| p.vel_x = 5 }
          @newTile = true
        end
      end
    when Gosu::KB_LEFT
      if @moveLeft
          @players.each { |p| p.vel_x = -5 }
          @newTile = true
      end
    when Gosu::KB_RIGHT
      if @moveRight
          @players.each { |p| p.vel_x = 5 }
          @newTile = true
      end
    else
      super
    end
  end

  def event

    e = ["Encounter", "Loot"]
    if(@players.size < 3)
      e << "Friendly"
    end
    e.shuffle!
    case(e.pop)
    when "Encounter"
      (rand(3)+1).times { @enemies << Enemy.new(@enemiesImages.shuffle.first, @players[0].x+500+@enemies.size*200, @players[0].y, @enemyRace) }
      @fighting = true
    when "Loot"
    when "Friendly"
    end

  end

  def needs_cursor?
    true
  end
end
