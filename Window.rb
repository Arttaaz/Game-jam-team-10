require 'gosu'
load 'Map.rb'
load 'Player.rb'
load 'Enemy.rb'
load 'IHM.rb'
load 'Skill.rb'
load 'Item.rb'
load 'Log.rb'
load 'SplashScreen.rb'
load 'Button.rb'

class Window < Gosu::Window

  def initialize(width, height)
    super(width, height)
    self.caption = "Ascension-3"
    @map = Map.new("assets/TileSet.png")
    @xStart = 100+8*1200
    @yStart = 250+ 4*600
    @personnage = false
    @moveRight = @moveLeft = @moveUp = false
    @newTile = false
    @fighting = false
    @hasKey = false
    @pToDelete = @eToDelete = []
    @log = Log.new(@xStart+580,@yStart+605)
    @splashKey = SplashScreen.new(Gosu::Image.new("assets/Items/Keycard.png", :tileable => true), "Vous récupérez la clé de l'étage !")
    @splashItem = SplashScreen.new(nil, "")
    @splashFriend = SplashScreen.new(Gosu::Image.new("assets/Friend.png", :tileable => true), "Vous avez trouvé un équipier !")
    @splashLevelUp = SplashScreen.new(Gosu::Image.new("assets/LevelUp.png", :tileable => true), "Un ou plusieurs personnages ont gagnés un niveau !")
    @splashWin = SplashScreen.new(nil, "Vous avez repris le contrôle d'Ascension-3 ! Bravo !")
    @splashLoose = SplashScreen.new(nil, "Vous avez perdu !")
    @font = Gosu::Font.new(20)
    @boutonJouer = Button.new("Jouer", 500,500,160,50,3000, Gosu::Color::BLUE, @font)
    @boutonCredits = Button.new("Crédits", 500,570,160,50,3000, Gosu::Color::BLUE, @font)
    @boutonQuitter = Button.new("Quitter", 500,640,160,50,3000, Gosu::Color::BLUE, @font)
    @boutonJouerClique=false
    @boutonCreditsClique=false
    @boutonQuitterClique=false
    @zBackground = 3000

    @mainTheme = Gosu::Song.new("media/Soundtracks/My Little Adventure.mp3")
    @mainTheme.play(true)
    @mainTheme.volume = 0.25

    @@ItemList =[
      Item.new("Armure régenérante", "assets/Items/Armure_regenerante.png"),
      Item.new("Armure vivante", "assets/Items/Armure_vivante.png"),
      Item.new("BFK","assets/Items/BFK.png"),
      Item.new("Bouclier énergétique","assets/Items/Bouclier_energetique.png"),
      Item.new("Chalumeau","assets/Items/Chalumeau.png"),
      Item.new("Cheveu divin","assets/Items/Cheveu_divin.png"),
      Item.new("Combinaison spatiale","assets/Items/Combinaison_spatiale.png"),
      Item.new("Couteau mortel","assets/Items/Couteau_mortel.png"),
      Item.new("Cyber-cerveau","assets/Items/Cyber-cerveau.png"),
      Item.new("Epée plasmique","assets/Items/Epee_plasmique.png"),
      Item.new("Gilet pare-balle","assets/Items/Gilet_pare-balle.png"),
      Item.new("Katana","assets/Items/Katana.png"),
      Item.new("Lampe blue","assets/Items/Lampe_bleue.png"),
      Item.new("Magnum 50mm","assets/Items/Magnum_50mm.png"),
      Item.new("Pistolet laser","assets/Items/Pistolet_laser.png"),
      Item.new("Pistolet sonique","assets/Items/Pistolet_sonique.png"),
      Item.new("Tablier de cuisine","assets/Items/Tablier_de_cuisine.png"),
      Item.new("Tournevis sonique","assets/Items/Tournevis_sonique.png"),
      Item.new("Uniforme de pilote","assets/Items/Uniforme_de_pilote.png"),
      Item.new("Yeux de perception","assets/Items/Yeux_de_perception.png")
    ]

    @players = [Player.new(@xStart,@yStart)]
    @enemies = []
    @ihm = IHM.new(@players[0].x-100,@players[0].y-250, @players, @enemies, @players[0], @fighting)
    @currentPlayer = @players[0]
    @enemyRace = ["Robot", "Infested"].shuffle.first

  end

  def update
    @splashKey.update
    @splashFriend.update
    @splashLoose.update
    @splashWin.update
    @splashItem.update
    @splashLevelUp.update
    if @fighting == false #if not in a fight
      if @players[0].vel_x == 0 && @players[0].vel_y == 0 #if not moving
        if @newTile == true
          @players.each { |p| p.regenRoom }
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
        else
          @moveUp = false
        end
      else
        @moveLeft = @moveRight = @moveUp = false
      end
    else                                    #########FIGHT#########
      @moveLeft = @moveRight = @moveUp = false                  # can't move



      if @currentActor.active == false                  #actor did stuff
        if @turnOrder.rotate!.first == nil
          @currentTurn = @currentTurn + 1
          @players.each { |p|
            p.regen
            p.skills.each { |s| s[1].update }}
          @currentActor = @turnOrder.rotate!.first[1]     #rotate to next actor
        else
          @currentActor = @turnOrder.first[1]
        end

        @currentActor.active = true if @currentActor.speed < 9000                    #actor can use skills ITS OVER NINE THOUSAAAAAANNNDS = stun
        if @currentActor.active == true
          if @currentActor.instance_of?(Player)           #if actor is player then set current player
            @currentPlayer = @currentActor
          else                                            # else start enemy ai
            @currentActor.ai(@players)
            @log.addLine("L'ennemi a attaqué " + @currentPlayer.name)
          end
        end
      end

      if @enemies.size == 0                                             #fin de fight
        if @map.currentTile(@players[0].x/1200.0, @players[0].y/600.0) == 10
          @splashWin.show
          puts "you win!"
          exit
        end
        @fighting = false
        luck = rand(100)
        if luck < 25
          @hasKey = true
          @splashKey.show
        end
        i = 0
        while i < @players.size
          if @players[i].items.size < 2
            @players[i].items << @@ItemList[rand(20)]
            @players[i].useItem(@players[i].items.last.name)
            @splashItem.image = @players[i].items.last.image
            @splashItem.message = Gosu::Image.from_text(@players[i].items.last.name, 50, :width => 460, :align => :center)
            @splashItem.show
            i = @players.size
          end
          i += 1
        end
        @players.each { |p|
          p.exp += 4+rand(3)
          if p.exp > 10
            @splashLevelUp.show
          end
         }
      end

    end
    @players.each { |p|
      p.update()
      if p.health == 0
        #Gosu::Sample.new("media/Sound effects/Wilhelm_scream.mp3").play(0.2)
        @pToDelete << p
      end
    }
    @pToDelete.each { |p|
      if @players.index(p) == 0
        @players.each { |p2| p2.x -= 150 }
      end
      @players.delete(p)
      @turnOrder.delete(p)
      if @players.size == 0
        @splashLoose.show
        sleep(2)
        puts "u loose"
        exit
      end
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

    @enemies.size.times { |i|
      @enemies[i].changePos(@players[0].x+500+i*200)
    }

    @ihm.update(@players[0].x,@players[0].y, @currentPlayer, @players, @enemies, @fighting)
    @log.update(@players[0].x+480,@players[0].y+357)

  end

  def draw
=begin
def draw
	bouton jouer pressé == false
	if bouton jouer pressé == false
		élément
		élément
		élément
		boutonJouer
		boutonJouer pressé = true
	end

  if true
    dessiner reste
=end
      if @boutonJouerClique==false
        Gosu::Image.new("assets/MainMenu.png").draw(0,0,@zBackground,0.2403846153846154,0.2467105263157895)
        #draw_rect(0,0,3000,3000,Gosu::Color::WHITE, @zBackground, :default)
        @boutonJouer.draw
        @boutonCredits.draw
        @boutonQuitter.draw
      end
      if @boutonJouerClique==true
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

          Gosu::Image.new("assets/selected.png", :tileable => true).draw(@currentPlayer.x-15, @currentPlayer.y+210, 3)
          @splashKey.draw(@players[0].x+200, @players[0].y-50)
          @splashItem.draw(@players[0].x+200, @players[0].y-50)
          @splashLoose.draw(@players[0].x+200, @players[0].y-50)
          @splashWin.draw(@players[0].x+200, @players[0].y-50)
          @splashFriend.draw(@players[0].x+200, @players[0].y-50)
          @splashLevelUp.draw(@players[0].x+200, @players[0].y-50)
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
          if @boutonJouerClique==true
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
          else
            if @boutonJouer.isClickedTS?(self.mouse_x,self.mouse_y)==true
              @boutonJouerClique=true
              @zBackground=0
            elsif @boutonCredits.isClickedTS(self.mouse_x,self.mouse_y)==true
              @boutonCreditsClique=true
            elsif @boutonQuitter.isClickedTS(self.mouse_x,self.mouse_y)==true
              @boutonQuitterClique=true
            end
          end
        @players.each { |p| @currentPlayer = p if p.isClicked?(self.mouse_x, self.mouse_y, @players[0].x) && @fighting == false}
      when Gosu::KB_LEFT
        if @moveLeft && @boutonJouerClique==true
          @players.each { |p| p.vel_x = -10 }
          @newTile = true
        end
      when Gosu::KB_RIGHT
        if @moveRight && @boutonJouerClique==true
          @players.each { |p| p.vel_x = 10 }
          @newTile = true
        end
      when Gosu::KB_UP
        if @moveUp && @boutonJouerClique==true
          @players.each { |p| p.vel_y = -10 }
          @newTile = true
          @hasKey = false
        end
      else
        super
      end
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
    when 11..45
        e = "Encounter"
    when 46..100
      e = "Nothing"
    end
    if @map.currentTile(@players[0].x/1200.0, @players[0].y/600.0) == 10
      @enemies << Enemy.new(@players[0].x+500, @players[0].y-100, @enemyRace, true)
      self.fight
    else
      case(e)
      when "Encounter"
        if(@players.size == 1)
          @enemies << Enemy.new(@players[0].x+500+@enemies.size*200, @players[0].y, @enemyRace)
        else
          (rand(3)+1).times { @enemies << Enemy.new(@players[0].x+500+@enemies.size*200, @players[0].y, @enemyRace) }
        end
        self.fight
      when "Friendly"
        @players << Player.new(@players[0].x+150*(@players.size), @players[0].y)
        @splashFriend.show
      end
    end
  end

  def fight
    @turnOrder = []
    @players.each { |p| @turnOrder << [p.speed, p]}
    @enemies.each { |e| @turnOrder << [e.speed, e]}

    @turnOrder.sort!{ |a, b| a[0] <=> b[0]}.reverse!
    @turnOrder << nil

    @currentTurn = 0
    @currentActor = @turnOrder.first[1]
    @fighting = true
    @currentActor.active = true   #actor can use skills

    if @currentActor.instance_of?(Player)           #if actor is player then set current player
      @currentPlayer = @currentActor
    else                                            # else start enemy ai
      @currentActor.ai(@players)
      @log.addLine("L'ennemi a attaqué " + @currentPlayer.name)
    end
  end

  def needs_cursor?
    true
  end
end
