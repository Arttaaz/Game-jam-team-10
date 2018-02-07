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
    @ihm = IHM.new(@players[0].x-100,@players[0].y-250, @players, @players[0])
    @currentPlayer = @players[0]
    @fighting = false
    @moveRight = @moveLeft = false
    @newTile = false

    @@SkillList = [

    ]


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
          @newTile = false
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
    else                                    #########FIGHT#########
      @moveLeft = @moveRight = false                  # can't move

      #player does stuff

      if @currentActor.active = false
        @CurrentActor = @turnOrder.rotate!.first[1]     #rotate to next actor
        if @currentActor == []                          #if actor is nil it's a new turn
          @currentTurn = @currentTurn + 1
          @players.each { |p| p.skills.each { |s| s.update }}
          @currentActor = @turnOrder.rotate!.first[1]
        end
        @currentActor.active = true                     #actor can use skills
        if @currentActor.instance_of?(Player)           #if actor is player then set current player
          @currentPlayer = @currentActor
        else                                            # else start enemy ai
          @currentActor.ai(@players)
        end
      end

      @enemies.each { |e| e.update() }                #update enemies state
    end
    @players.each { |p| p.update() }
    @ihm.update(@players[0].x,@players[0].y, @currentPlayer)

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
      @ihm.click(self.mouse_x, self.mouse_y, -@players[0].x+100, -@players[0].y+250)
      if @moveLeft && self.mouse_x >= 30 && self.mouse_x <= 80
        if self.mouse_y >= 150 && self.mouse_y <= 450
          @players.each { |p| p.vel_x = -10 }
          @newTile = true
        end
      elsif @moveRight && self.mouse_x >= 1100 && self.mouse_x <= 1150
        if self.mouse_y >= 150 && self.mouse_y <= 450
          @players.each { |p| p.vel_x = 10 }
          @newTile = true
        end
      end
      @players.each { |p| @currentPlayer = p if p.isClicked?(self.mouse_x, self.mouse_y, @players[0].x)}
      if @enemies != []
        @enemies.each { |e| e.isClicked?(self.mouse_x, self.mouse_y, @enemies[0].x)}
      end
    when Gosu::KB_LEFT
      if @moveLeft
          @players.each { |p| p.vel_x = -10 }
          @newTile = true
      end
    when Gosu::KB_RIGHT
      if @moveRight
          @players.each { |p| p.vel_x = 10 }
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
      self.fight
    when "Loot"
    when "Friendly"
    end
  end

  def fight
    @turnOrder = []
    @players.each { |p| @turnOrder << [p.speed, p]}
    @enemies.each { |e| @turnOrder << [e.speed, e]}

    @turnOrder.sort!{ |a, b| a[0] <=> b[0]}.reverse!
    @turnOrder << []
    @currentTurn = 0
    @currentActor = @turnOrder.first[1]


    if @currentActor.instance_of?(Player)           #if actor is player then set current player
      @currentActor.active = true                   #actor can use skills
      @currentPlayer = @currentActor
    else                                            # else start enemy ai
      @currentActor.ai(@players)
    end
  end

  def needs_cursor?
    true
  end
end
