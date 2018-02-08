require 'gosu'
load 'Map.rb'
load 'Player.rb'
load 'Enemy.rb'
load 'IHM.rb'
load 'Skill.rb'
load 'Item.rb'

class Window < Gosu::Window

  def initialize(width, height)
    super(width, height)
    self.caption = "Ascension-3"
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
#name, type, who, modifier, image, cost = 0, duration = 0, temp = false, dmgType = nil target = nil

    @@SkillList = [
      [Type::PASSIVE, MaxPowerModif.new("Libre arbitre", Type::PASSIVE, Who::SELF, 25, "assets/Skills/Races/Humain/1_Libre_arbitre.png")],
      [Type::ACTIVE, DmgModif.new("Concentration", Type::ACTIVE, Who::SELF, 25, "assets/Skills/Races/Humain/2_Concentration.png", 15, 2, true)],
      [Type::PASSIVE, Heal.new("Auto-reparateur", Type::PASSIVE, Who::SELF, 10, "assets/Skills/Races/Robot/1_Auto-repaire.png")],
      [Type::ACTIVE, SpeedModif.new("Taser", Type::ACTIVE, Who::ENEMY, 9000, "assets/Skills/Races/Robot/2_Taser.png", 17, 1, true)],
      [Type::PASSIVE, DmgModif.new("Volonte de fer", Type::PASSIVE, Who::SELF, 10, "assets/Skills/Classes/Soldat/01-1_Volontee_de_fer.png")],
      [Type::ACTIVE, Dmg.new("Tire puissant", Type::ACTIVE, Who::ENEMY, 120, "assets/Skills/Classes/Soldat/01-2_Tire_puissant.png", 17, 0, false, DmgType::PHYS)],
      [Type::PASSIVE, DmgModif.new("Munition lourde", Type::PASSIVE, Who::SELF, 15, "assets/Skills/Classes/Soldat/03-1_Munition_lourde.png")],
      [Type::PASSIVE, PowerRegenModif.new("Vigeur", Type::PASSIVE, Who::SELF, 15, "assets/Skills/Classes/Soldat/03-2_Vigeur.png")],
      [Type::ACTIVE, Dmg.new("Grenade militaire", Type::ACTIVE, Who::ENEMIES, 70, "assets/Skills/Classes/Soldat/06-1_Grenade_militaire.png", 22, 0, false, DmgType::PHYS)],
      [Type::ACTIVE, Dmg.new("Grenade photonique", Type::ACTIVE, Who::ENEMIES, 70, "assets/Skills/Classes/Soldat/06-2_Grenade_photonique.png", 22, 0, false, DmgType::ENG)],
      [Type::PASSIVE, DmgModif.new("Expert d'arme", Type::PASSIVE, Who::SELF, 20, "assets/Skills/Classes/Soldat/09-1_Expert_d'arme.png")],
      [Type::PASSIVE, PowerRegenModif.new("Determination", Type::PASSIVE, Who::SELF, 25, "assets/Skills/Classes/Soldat/09-2_Determination.png")],
      [Type::ACTIVE, Dmg.new("Coutean militaire", Type::ACTIVE, Who::ENEMY, 40, "assets/Skills/Classes/Soldat/12-1_Couteau_militaire.png", 17, 3, true, DmgType::PHYS)],
      [Type::ACTIVE, Dmg.new("Lame plasmique", Type::ACTIVE, Who::ENEMY, 120, "assets/Skills/Classes/Soldat/12-2_Lame_plasmique.png", 17, 0, false, DmgType::ENG)],
      [Type::PASSIVE, PhysDefModif.new("Vulnerabilite physique", Type::PASSIVE, Who::ENEMIES, -20, "assets/Skills/Classes/Soldat/15-1_Vulnerabilite_physique.png")],
      [Type::PASSIVE, EngDefModif.new("Vulnerabilite energetique", Type::PASSIVE, Who::ENEMIES, -20, "assets/Skills/Classes/Soldat/15-2_Vulnerabilite_energetique.png")],
      [Type::ACTIVE, Dmg.new("Shotgun", Type::ACTIVE, Who::ENEMIES, 150, "assets/Skills/Classes/Soldat/18-1_Shotgun.png", 40, 0, false, DmgType::PHYS)],
      [Type::ACTIVE, Dmg.new("Railgun", Type::ACTIVE, Who::ENEMY, 350, "assets/Skills/Classes/Soldat/18-2_Railgun.png", 40, 0, false, DmgType::ENG)],
      [Type::PASSIVE, ExpModif.new("Connaissance", Type::PASSIVE, Who::ALLIES, 10, "assets/Skills/Classes/Scientifique/01-1_Connaissance.png")],
      [Type::ACTIVE, ResModif.new("Analyse", Type::ACTIVE, Who::ENEMY, -15, "assets/Skills/Classes/Scientifique/01-2_Analyse.png", 10, 3, true)],
      [Type::PASSIVE, Heal.new("Placebo", Type::PASSIVE, Who::ALLIES, 5, "assets/Skills/Classes/Scientifique/03-1_Placebo.png")],
      [Type::PASSIVE, ResModif.new("Vapeur nefaste", Type::PASSIVE, Who::ENEMIES, -10, "assets/Skills/Classes/Scientifique/03-2_Vapeur_nefaste.png")],
      [Type::ACTIVE, Heal.new("Soin", Type::ACTIVE, Who::ALLY, 80, "assets/Skills/Classes/Scientifique/06-1_Soin.png", 30)],
      [Type::ACTIVE, Dmg.new("Coctel chimique", Type::ACTIVE, Who::ENEMIES, 20, "assets/Skills/Classes/Scientifique/06-2_Coctel_chimique.png", 20, 3, true, DmgType::ENG)],
      [Type::PASSIVE, SpeedModif.new("Vitesse", Type::PASSIVE, Who::ALLIES, 3, "assets/Skills/Classes/Scientifique/09-1_Vitesse.png")],
      [Type::PASSIVE, DmgModif.new("Prevoyance", Type::PASSIVE, Who::ENEMIES, -15, "assets/Skills/Classes/Scientifique/09-2_Prevoyance.png")],
      [Type::ACTIVE, Heal.new("Medicament", Type::ACTIVE, Who::ALLY, 15, "assets/Skills/Classes/Scientifique/12-1_Medicament.png", 32, 5, true)],
      [Type::ACTIVE, ResModif.new("Faiblesse", Type::ACTIVE, Who::ENEMY, -50, "assets/Skills/Classes/Scientifique/12-2_Faiblesse.png", 28, 1, true)],
      [Type::PASSIVE, ResModif.new("Resistance", Type::PASSIVE, Who::ALLIES, 15, "assets/Skills/Classes/Scientifique/15-1_Resistance.png")],
      [Type::PASSIVE, SpeedModif.new("Ralentissement", Type::PASSIVE, Who::ENEMIES, 5, "assets/Skills/Classes/Scientifique/15-2_ralentissement.png")],
      [Type::ACTIVE, Heal.new("Soin de masse", Type::ACTIVE, Who::ALLIES, 200, "assets/Skills/Classes/Scientifique/18-1_Soin_de_masse.png", 50)],
      [Type::ACTIVE, SpeedModif.new("Grenade flash", Type::ACTIVE, Who::ENEMIES, 9000, "assets/Skills/Classes/Scientifique/18-2_Grenade_flash.png", 45, 1, true)]
    ]

    @@ItemList =[
      Item.new("Armure regenerante", "assets/Items/Armure_regenerante.png"),
      Item.new("Armure vivante", "assets/Items/Armure_vivante.png"),
      Item.new("BFK","assets/Items/BFK.png"),
      Item.new("Bouclier energetique","assets/Items/Bouclier_energetique.png"),
      Item.new("Chalumeau","assets/Items/Chalumeau.png"),
      Item.new("Cheveu divin","assets/Items/Cheveu_divin.png"),
      Item.new("Combinaison spatiale","assets/Items/Combinaison_spatiale.png"),
      Item.new("Couteau mortel","assets/Items/Couteau_mortel.png"),
      Item.new("Cyber-cerveau","assets/Items/Cyber-cerveau.png"),
      Item.new("Epee plasmique","assets/Items/Epee_plasmique.png"),
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

    @players.each { |p|
      p.skills[0] = @@SkillList[5]
      p.skills[1] = @@SkillList[0]
      p.skills[2] = @@SkillList[8]
      p.skills[3] = @@SkillList[9]
      p.skills[4] = @@SkillList[12]
      p.skills[5] = @@SkillList[2]
      p.skills[6] = @@SkillList[4]
      p.skills[7] = @@SkillList[13]
      p.skills[8] = @@SkillList[11]
      p.skills[9] = @@SkillList[14]
      p.skills[10] = @@SkillList[15]
      p.items[0] = @@ItemList[3]
      p.items[1] = @@ItemList[6]
      p.useItem(p.items[0].name)
      p.useItem(p.items[1].name)
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
          @players.each { |p| p.skills.each { |s| s[1].update }}
          @currentActor = @turnOrder.rotate!.first[1]     #rotate to next actor
        else
          @currentActor = @turnOrder.first[1]
        end

        @currentActor.active = true                     #actor can use skills
        if @currentActor.instance_of?(Player)           #if actor is player then set current player
          @currentPlayer = @currentActor
        else                                            # else start enemy ai
          @currentActor.ai(@players)
        end
      end

      if @enemies.size == 0
        @fighting = false
        luck = rand(100)
        if luck < 25
          @hasKey = true
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
      if @players.size == 0
        puts "Game over!"
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
      #if @enemies != []
      #  @enemies.each { |e| e.isClicked?(self.mouse_x, self.mouse_y, @enemies[0].x)}
      #end
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
      @players.last.skills[0] = @@SkillList[5]
      @players.last.skills[1] = @@SkillList[0]
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
    end
  end

  def needs_cursor?
    true
  end
end
