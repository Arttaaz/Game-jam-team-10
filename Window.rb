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
    @yStart = 250+ 4*600
    @players = [Player.new("assets/testchar.png",@xStart,@yStart)]
    @enemies = []
    @ihm = IHM.new(@players[0].x-100,@players[0].y-250, @players, @enemies, @players[0], @fighting)
    @currentPlayer = @players[0]
    @personnage = false
    @moveRight = @moveLeft = @moveUp = false
    @newTile = false
    @fighting = false
    @hasKey = false
    @pToDelete = @eToDelete = []
#name, type, who, modifier, image, cost = 0, duration = 0, temp = false, target = nil
    @@SkillList = [
      [Type::PASSIVE, MaxPowerModif.new("Libre Arbitre", Type::PASSIVE, Who::SELF, 25, "assets/Skills/Races/Humain/1_Libre_arbitre.png")],
      [Type::ACTIVE, DmgModif.new("Concentration", Type::ACTIVE, Who::SELF, 25, "assets/Skills/Races/Humain/2_Concentration.png", 15, 2, true)],
      [Type::PASSIVE, HealthModif.new("Auto-reparateur", Type::PASSIVE, Who::SELF, 10, "assets/Skills/Races/Robot/1_Auto-repaire.png")],
      [Type::ACTIVE, SpeedModif.new("Taser", Type::ACTIVE, Who::ENEMY, 9000, "assets/Skills/Races/Robot/2_Taser.png", 17, 1, true)]
    ]

    @players.each { |p|
      p.skills[0][1] = @@SkillList[1][1]
      p.skills[1][1] = @@SkillList[0][1]
    }

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
      if @players[0].vel_x == 0 && @players[0].vel_y == 0 #if not moving
        if @newTile == true
          self.event
          @newTile = false
        end
        if (@map.move?(@players[0].x/1200.0, @players.last.x/1200.0, @players[0].y/600.0, Direction::LEFT))
          @moveLeft = true
        else
          @moveLeft = false
        end

        if(@map.move?(@players[0].x/1200.0, @players.last.x/1200.0, @players[0].y/600.0, Direction::RIGHT))
          @moveRight = true
        else
          @moveRight = false
        end
        if @hasKey
          if(@map.move?(@players[0].x/1200.0, @players.last.x/1200.0, @players[0].y/600.0, Direction::UP))
            @moveUp = true
          else
            @moveUp = false
          end
        end
      else
        @moveLeft = @moveRight = @moveUp = false
      end
    else                                    #########FIGHT#########
      @moveLeft = @moveRight = @moveUp = false                  # can't move

      if @ennemies == []
        @fighting = false
        luck = rand(100)
        if luck < 25
          @hasKey = true
        end
      end

      if @currentActor.active == false                  #actor did stuff
        @currentActor = @turnOrder.rotate!.first[1]     #rotate to next actor
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

    end
    @players.each { |p|
      p.update()
      if p.health == 0
        @pToDelete << p
      end
    }
    @pToDelete.each { |p|
      @players.delete(p)
      @turnOrder.delete(p)
    }
    @enemies.each { |e|
      e.update()
      if e.health == 0
        @eToDelete << e
      end
    }
    @eToDelete.each { |e|
      @enemies.delete(e)
      @turnOrder.delete(e)
    }
    @ihm.update(@players[0].x,@players[0].y, @currentPlayer, @players, @enemies, @fighting)

  end

  def draw
    Gosu.translate(-@players[0].x+100, -@players[0].y+250) do
      @map.draw()
      @players.each { |p| p.draw() }
      Gosu.draw_rect(@players[0].x-100, 600+@players[0].y-250, 1200, 300, Gosu::Color::GRAY, 0)
      @ihm.draw
      if @moveLeft
        Gosu::Image.new("assets/Arrow.png", :tileable => true).draw(@players[0].x-30, @players[0].y, 2, -1)
      end
      if @moveRight
        Gosu::Image.new("assets/Arrow.png", :tileable => true).draw(@players[0].x+1000, @players[0].y, 2)
      end
      if @moveUp
        Gosu::Image.new("assets/Arrow2.png", :tileable => true).draw(@players[0].x+323, @players[0].y-180, 2, 1, -1)
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
        if self.mouse_y >= 250 && self.mouse_y <= 550
          @players.each { |p| p.vel_x = -10 }
          @newTile = true
        end
      elsif @moveRight && self.mouse_x >= 1100 && self.mouse_x <= 1150
        if self.mouse_y >= 250 && self.mouse_y <= 550
          @players.each { |p| p.vel_x = 10 }
          @newTile = true
        end
      elsif @moveUp && self.mouse_y >= 30 && self.mouse_y <= 70
        if self.mouse_x >= 433 && self.mouse_x <= 733
          @players.each { |p| p.vel_y = -10 }
          @hasKey = false
          @newTile = true
        end
      end
      @players.each { |p| @currentPlayer = p if p.isClicked?(self.mouse_x, self.mouse_y, @players[0].x) && @fighting == false}
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
    when Gosu::KB_UP
      if @moveUp
        @players.each { |p| p.vel_y = -10 }
        @newTile = true
        @hasKey = false
      end
    else
      super
    end
  end

  def event

    p = rand(100)+1
    case p
    when 1..10
      if(@players.size < 3)
        e = "Friendly"
      else
        e = "Nothing"
      end
    when 11..55
        e = "Encounter"
    when 56..75
      e = "Loot"
    when 76..100
      e = "Nothing"
    end

    case(e)
    when "Encounter"
      (rand(3)+1).times { @enemies << Enemy.new(@enemiesImages.shuffle.first, @players[0].x+500+@enemies.size*200, @players[0].y, @enemyRace) }
      self.fight
    when "Loot"
    when "Friendly"
      @players << Player.new("assets/testchar.png", @players[0].x+150*(@players.size), @players[0].y)
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
    @fighting = true
    @currentActor.active = true   #actor can use skills

    if @currentActor.instance_of?(Player)           #if actor is player then set current player
      @currentPlayer = @currentActor
    else                                            # else start enemy ai
      @currentActor.ai(@players)
    end
  end

  def needs_cursor?
    true
  end
end
