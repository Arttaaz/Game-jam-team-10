require 'gosu'
load 'Player.rb'
load 'Button.rb'
load 'Skill.rb'
load 'Log.rb'


class IHM < Gosu::Window

  def initialize(x,y, players, enemies, player, fighting)
    @x = x
    @y = y
    @font = Gosu::Font.new(20)
    @enemies = enemies
    @players = players
    @player = player
    @personnage = Button.new("Personnage", @x-100,@y+350,160,50,2,Gosu::Color::WHITE, @font)
    @stats = Button.new("Stats", @x+70,@y+350,150,50,2,Gosu::Color::WHITE, @font)
    @skills = Button.new("Capacités", @x+275,@y+350,150,50,2,Gosu::Color::WHITE, @font)

    @box = 0
    @fighting = fighting
    @pendingSkill = []
    @waitTarget = false
    @log = Log.new(@x+580,@y+605)
  end

  def draw
    @personnage.draw
    @stats.draw
    @skills.draw

    self.box
  end

  def update(x,y, player, players, enemies, fighting)
    @x = x
    @y = y
    @player = player
    @players = players
    @enemies = enemies
    @personnage.update(x-100, y+350)
    @stats.update(x+70, y+350)
    @skills.update(x+230, y+350)
    @fighting = fighting
    @log.update(@x+480,@y+357)
    if @waitTarget
      if @pendingSkill[0] == Who::SELF
        @pendingSkill[1].target = @player
        @player.power -= @pendingSkill[1].activate(@player)
        @player.active = false
        @waitTarget = false
        @log.addLine(@player.name + " a utilisé " + @pendingSkill[1].name + " sur lui-même")
      elsif @pendingSkill[0] == Who::ALLIES
        @pendingSkill[1].target = @players
        @player.power -= @pendingSkill[1].activate(@player)
        @log.addLine(@player.name + " a utilisé " + @pendingSkill[1].name + " sur tous les alliés")
        @player.active = false
        @waitTarget = false
      elsif @pendingSkill[0] == Who::ENEMIES
        @pendingSkill[1].target = @enemies.to_a
        @player.power -= @pendingSkill[1].activate(@player)
        @player.active = false
        @waitTarget = false
        @log.addLine(@player.name + " a utilisé " + @pendingSkill[1].name + " sur tous les ennemis")
      end
    end
  end

  def click(x, y, xx, yy)
    if @waitTarget
      @players.each { |p|
        if p.isClicked?(x, y, @players[0].x)
          case @pendingSkill[0]
          when Who::ALLY
            @pendingSkill[1].target = p
            @player.power -= @pendingSkill[1].activate(@player)
            @player.active = false
            @waitTarget = false
            @log.addLine(@player.name + " a utilisé " + @pendingSkill[1].name + " sur " + p.name)
          end
        end
      }
      @enemies.each { |e|       #チキンナゲットが大好き

        if e.isClicked?(x, y, @enemies[0].x)
          case @pendingSkill[0]
          when Who::ENEMY
            @pendingSkill[1].target = e
            @player.power -= @pendingSkill[1].activate(@player)
            @player.active = false
            @waitTarget = false
            @log.addLine(@player.name + " a attaqué avec " + @pendingSkill[1].name)
          end
        end
      }
    else
      @box = 0 if @personnage.isClicked?(x, y, xx, yy) == true
      @box = 1 if @stats.isClicked?(x, y, xx, yy) == true
      @box = 2 if @skills.isClicked?(x, y, xx, yy) == true
      @players.each do |player|
        player.skills.each do |skill|
          if skill[1].isClicked?(x, y, xx, yy)
            if @box == 2
              addSkillDesc(skill[1].name)
            end
          end
        end
      end
      @player.skills.each { |s|
        if s[0] == Type::ACTIVE
          if s[1].isClicked?(x, y, xx, yy)
            if @fighting && @box == 0
              if @player.power > s[1].cost
                @pendingSkill = [s[1].who, s[1]]
                @log.addLine("Choisissez une cible")
                @waitTarget = true
              end
=begin
            elsif @box == 2
              addSkillDesc(s[1].name)
=end
            end

          end
=begin
        else
          if s[1].isClicked?(x, y, xx, yy)
            if @box == 2
              addSkillDesc(s[1].name)
            end
          end
=end
        end
      }
    end
  end

  def box

    case(@box)
      when 0 #personnage
      if @fighting==true
        draw_rect(@x+475,@y+355,610,290,Gosu::Color::BLACK, z=0, :default) #mini map

        @font.draw("Santé: " + @player.health.to_s + "/" + @player.maxHealth.to_s,  @x-90, @y+410, 1, 1.0, 1.0, Gosu::Color::GREEN)
        @font.draw("Bouclier: " + @player.shield.to_s + "/" + @player.maxShield.to_s,  @x-90, @y+440, 1, 1.0, 1.0, Gosu::Color::CYAN)
        @font.draw("Power: " + @player.power.to_s + "/" + @player.maxPower.to_s,  @x-90, @y+470, 1, 1.0, 1.0, Gosu::Color::FUCHSIA)

        @font.draw("Dégâts: " + @player.damage.to_s,  @x+80, @y+410, 1, 1.0, 1.0, Gosu::Color::BLACK)
        @font.draw("Déf. physique: " + @player.phy_def.to_s,  @x+80, @y+440, 1, 1.0, 1.0, Gosu::Color::BLACK)
        @font.draw("Déf. énergie: " + @player.eng_def.to_s,  @x+80, @y+470, 1, 1.0, 1.0, Gosu::Color::BLACK)
        @font.draw("Vitesse: " + @player.speed.to_s,  @x+80, @y+500, 1, 1.0, 1.0, Gosu::Color::BLACK)

        draw_rect(@x+230,@y+410,60,60,Gosu::Color::WHITE, z=0, :default)
        if @player.items.size > 0
          @player.items[0].draw(@x+230,@y+410)
          @player.items[0].drawNameIB(@x+295, @y+430)
        end

        draw_rect(@x+230,@y+480,60,60,Gosu::Color::WHITE, z=0, :default)
        if @player.items.size > 1
          @player.items[1].draw(@x+230,@y+480)
          @player.items[1].drawNameIB(@x+295, @y+500)
        end

        dx=0
        @player.skills.each do |skill|
          if skill[0]==Type::ACTIVE
            skill[1].draw(@x+dx-90, @y+550)
            dx=dx+75
          end
        end

        writeNameA(@player.name,@x-90, @y+615, 1.7,1.7)
        writeLvl(@player.level,@x+190, @y+615, 1.7,1.7)

        @log.dispLog
      else #@fighting==false
        draw_rect(@x+475,@y+355,610,290,Gosu::Color::BLACK, z=1, :default) #mini map

        @font.draw("Santé: " + @player.health.to_s + "/" + @player.maxHealth.to_s,  @x-90, @y+410, 1, 1.0, 1.0, Gosu::Color::GREEN)
        @font.draw("Bouclier: " + @player.shield.to_s + "/" + @player.maxShield.to_s,  @x-90, @y+440, 1, 1.0, 1.0, Gosu::Color::CYAN)
        @font.draw("Power: " + @player.power.to_s + "/" + @player.maxPower.to_s,  @x-90, @y+470, 1, 1.0, 1.0, Gosu::Color::FUCHSIA)

        @font.draw("Dégâts: " + @player.damage.to_s,  @x+80, @y+410, 1, 1.0, 1.0, Gosu::Color::BLACK)
        @font.draw("Déf. physique: " + @player.phy_def.to_s,  @x+80, @y+440, 1, 1.0, 1.0, Gosu::Color::BLACK)
        @font.draw("Déf. énergie: " + @player.eng_def.to_s,  @x+80, @y+470, 1, 1.0, 1.0, Gosu::Color::BLACK)
        @font.draw("Vitesse: " + @player.speed.to_s,  @x+80, @y+500, 1, 1.0, 1.0, Gosu::Color::BLACK)

        draw_rect(@x-90,@y+550,60,60,Gosu::Color::WHITE, z=0, :default)
        if @player.items.size > 0
          @player.items[0].draw(@x-90,@y+550)
          @player.items[0].drawNameOB(@x-25, @y+565)
        end

        draw_rect(@x+190,@y+550,60,60,Gosu::Color::WHITE, z=0, :default)
        if @player.items.size > 1
          @player.items[1].draw(@x+190,@y+550)
          @player.items[1].drawNameOB(@x+255, @y+565)
        end

        writeNameA(@player.name,@x-90, @y+615, 1.7,1.7)
        writeLvl(@player.level,@x+190, @y+615, 1.7,1.7)

        @log.dispLog
      end
      when 1 # stats
        d=0
        @players.size.times do |n|
          @font.draw("Santé: " + @players[n].health.to_s + "/" + @players[n].maxHealth.to_s,  @x+d-90, @y+410, 1, 1.0, 1.0, Gosu::Color::GREEN)
          @font.draw("Bouclier: " + @players[n].shield.to_s + "/" + @players[n].maxShield.to_s,  @x+d-90, @y+435, 1, 1.0, 1.0, Gosu::Color::CYAN)
          @font.draw("Power: " + @players[n].power.to_s + "/" + @players[n].maxPower.to_s,  @x+d-90, @y+460, 1, 1.0, 1.0, Gosu::Color::FUCHSIA)
          @font.draw("Dégâts: " + @players[n].damage.to_s,  @x+d-90, @y+485, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Réduc. dégâts: " + @players[n].dmgReduc.to_s + "%",  @x+d-90, @y+510, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Déf. physique: " + @players[n].phy_def.to_s,  @x+d-90, @y+535, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Déf. énergie: " + @players[n].eng_def.to_s,  @x+d-90, @y+560, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Classe: " + @players[n].class,  @x+d+90, @y+410, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Race: " + @players[n].race,  @x+d+90, @y+435, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Régén. power: " + @players[n].powRegen.to_s,  @x+d+90, @y+460, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Vitesse: " + @players[n].speed.to_s,  @x+d+90, @y+485, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Expérience: " + @players[n].exp.to_s,  @x+d+90, @y+510, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Bonus exp: " + @players[n].expBonus.to_s + "%",  @x+d+90, @y+535, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Niveau " + @players[n].level.to_s, @x+d+90, @y+560, 1,1,1,Gosu::Color::BLACK)
          writeNameB(@players[n].name,@x+d+5, @y+590, 1.7,1.7,n)
        d=d+420
        end
      when 2 # skills
        @font.draw("Cliquez sur une capacité pour avoir sa description dans le log !", @x+405, @y+360, 1, 1.3,1.3, Gosu::Color::BLACK)
        @font.draw("Actives",  @x+258, @y+403, 1, 1.3, 1.3, Gosu::Color::BLACK)
        @font.draw("Passives",  @x+780, @y+403, 1, 1.3, 1.3, Gosu::Color::BLACK)
        dy=0
        @players.size.times { |n|
          dxa=dxp=0
          writeNameB(@players[n].name,@x-90, @y+dy+445, 1.3,1.3,n)
          @players[n].skills.each { |skill|
            case(skill[0])
            when Type::ACTIVE
              skill[1].draw(@x+dxa+120,@y+dy+430)
              dxa=dxa+75
            when Type::PASSIVE
              skill[1].draw(@x+dxp+612,@y+dy+430)
              dxp=dxp+75
            end
          }
          dy=dy+75
        }
      end
    end

    def writeNameA(name, x, y, sx, sy)
      if @player.class=="Soldat"
        @font.draw(name, x, y, 1, sx,sy , Gosu::Color.argb(0xff_22b14c)) #vert plus foncé
      elsif @player.class=="Scientifique"
        @font.draw(name, x, y, 1, sx,sy , Gosu::Color::BLUE)
      else #@player.class=="Ingénieur" || @players[c].class=="Ingénieur"
        @font.draw(name, x, y, 1, sx,sy , Gosu::Color.argb(0xff_FFD500)) #gold
      end
    end

    def writeNameB(name, x, y, sx, sy, c) #for arrays #character n°c
      if @players[c].class=="Soldat"
        @font.draw(name, x, y, 1, sx,sy , Gosu::Color.argb(0xff_22b14c)) #vert plus foncé
      elsif @players[c].class=="Scientifique"
        @font.draw(name, x, y, 1, sx,sy , Gosu::Color::BLUE)
      else #@players[c].class=="Ingénieur"
        @font.draw(name, x, y, 1, sx,sy , Gosu::Color.argb(0xff_FFD500)) #gold
      end
    end


    def writeLvl(lvl, x, y, sx, sy)
      if @player.class=="Soldat"
        @font.draw("Nv. " + lvl.to_s, x, y, 1, sx,sy , Gosu::Color.argb(0xff_22b14c)) #vert plus foncé
      elsif @player.class=="Scientifique"
        @font.draw("Nv. " + lvl.to_s, x, y, 1, sx,sy , Gosu::Color::BLUE)
      else #@player.class=="Ingénieur" || @players[c].class=="Ingénieur"
        @font.draw("Nv. " + lvl.to_s, x, y, 1, sx,sy , Gosu::Color.argb(0xff_FFD500)) #gold
      end
    end

    def addSkillDesc(skillName)
      case(skillName)
      when "Volonte de fer"
        @log.addLine("Volonté de fer: Augmente la réduction de dégâts de l’utilisateur de 10%")
      when "Tire puissant"
        @log.addLine("Tir puissant: Inflige 120% de dégâts physiques  une cible enemie")
      when "Munition lourde"
        @log.addLine("Munition lourde: Augmente les dégâts de l’utilisateur de 15%")
      when "Vigeur"
        @log.addLine("Vigeur: Augmente la régénération de power de 15%")
      when "Grenade militaire"
        @log.addLine("Grenade militaire: Inflige 70% de dégâts physiques a tous les ennemis")
      when "Attaque"
        @log.addLine("Attaque: simple attaque")
      when "Grenade militaire"
        @log.addLine("Grenade militaire: Inflige 70% de dégâts physiques à tous les ennemis")
      when "Grenade photonique"
        @log.addLine("Grenade photonique: Inflige 70% de dégâts énergétique a tous les ennemis")
      when "Determination"
        @log.addLine("Determination: Augmente la régénération de power de 25%")
      when "Coutean militaire"
        @log.addLine("Couteau militaire: Inflige 40% de dégâts physiques à un ennemi pendant 3 tours")
      when "Libre arbitre"
        @log.addLine("Libre arbitre: Augmente le power maximum de 25%")
      when "Concentration"
        @log.addLine("Concentration: Augmente les dégâts de l’utilisateur de 25% pendant 2 tours")
      when "Auto-reparateur"
        @log.addLine("Auto-réparateur: Permet de régénérer 25% de vie supplémentaire chaque tour")
      when "Taser"
        @log.addLine("Taser: Paralyse l’ennemi pendant 1 tour")
      when "Expert d'arme"
        @log.addLine("(p) Expert d’arme: Augmente les dégâts de l’utilisateur de 20%")
      when "Lame plasmique"
        @log.addLine("Lame plasmique: Inflige 120% de dégâts énergétique a un ennemi")
      when "Vulnerabilite physique"
        @log.addLine("Vulnérabilité physique: Réduit la résistance physique de tous les ennemis de 20%")
      when "Vulnerabilite energetique"
        @log.addLine("Vulnérabilité énergétique: Réduit la résistance énergétique de tous les ennemis de 20%")
      when "Shotgun"
        @log.addLine("Shotgun: Inflige 150% de dégâts physique à tous les ennemis")
      when "Railgun"
        @log.addLine("Railgun: Inflige 350% de dégâts énergétique à un ennemi")
      when "Connaissance"
        @log.addLine("Connaissance: Augmente la quantité d’expérience obtenue a la fin d’un combat de 10%")
      when "Analyse"
        @log.addLine("Analyse: Réduit les résistances d’un ennemi de 15% pendant 3 tours")
      when "Placebo"
        @log.addLine("Placebo: Soigne tous les membres de l’équipe de 5% a la fin d’un tour")
      when "Vapeur nefaste"
        @log.addLine("Vapeur néfaste: Réduit les résistances de tous les ennemis de 10%")
      when "Soin"
        @log.addLine("Soin: Soigne un allié de 80% des dégâts de l’utilisateur")
      when "Cocktail chimique"
        @log.addLine("Cocktail chimique: Inflige 20% de dégâts énergétique a tous les ennemis pendant 2 tours")
      when "Vitesse"
        @log.addLine("Vitesse: Augmente la vitesse de toute l’equipe de 3")
      when "Prevoyance"
        @log.addLine("Prévoyance: Réduit les dégâts que les ennemis font de 15%")
      when "Medicament"
        @log.addLine("Médicament: Permet à un allié de se soigne 15% des dégâts de l’utilisateur pendant 5 tours")
      when "Faiblesse"
        @log.addLine("Faiblesse: Réduit les résistances d’un ennemi de 50% pendant 1 tour")
      when "Resistance"
        @log.addLine("Résistance: Augmente la réduction de dégâts de toute l’equipe de 15%")
      when "Ralentissement"
        @log.addLine("Ralentissement: Réduit la vitesse des ennemis de 5")
      when "Soin de masse"
        @log.addLine("Soin de masse: Soigne toute l’equipe de 200% des dégâts de l’utilisateur")
      when "Grenade flash"
        @log.addLine("Grenade flash: Etourdit tous les ennemis pendant 1 tour")
      when "Endurance"
        @log.addLine("Endurance: Augmente la régénération de power de toute l’equipe de 35%")
      when "Assistance"
        @log.addLine("Assistance: Augmente les résistances d’un allié de 35% pendant 1 tour")
      when "Adaptation"
        @log.addLine("Adaptation: Augmente les résistances de l’utilisateur de 15%")
      when "Reparation"
        @log.addLine("Réparation: Donne a toute l’equipe 20% de régénération de bouclier par tour")
      when "Vitalite"
        @log.addLine("Vitalité: Donne à l’utilisateur un bonus de 50% de sa vie maximale")
      when "Restoration"
        @log.addLine("Restoration: Redonne a un allie 40% de ses boucliers")
      when "Redirection"
        @log.addLine("Redirection: Augmente la capacité maximale des boucliers de toute l’equipe de 20%")
      when "Augmentation"
        @log.addLine("Augmentation: Augmente les dégâts de l’equipe de 10%")
      when "Super regeneration"
        @log.addLine("Super regeneration: Donne à l’utilisateur un soin de 10% de ses dégâts pendant 5 tours")
      when "Acceleration"
        @log.addLine("Accélération: Augmente la vitesse de l’equipe de 7 pendant 3 tours")
      when "Contre"
        @log.addLine("Contre: Réduit la vitesse des ennemis de 4")
      when "Armure renforcee"
        @log.addLine("Armure renforcée: Augmente les résistances de toute l’equipe de 15%")
      when "Mastodonte"
        @log.addLine("Mastodonte: Augmente les résistances de l’utilisateur de 100% pendant 1 tour")
      when "Barriere"
        @log.addLine("Barrière: Redonne à tous les membres de l’équipe 70% de leur bouclier")
      end
    end


end


=begin
Gosu::Image.from_text().draw()

Gamejam 2018 Groupe 10: Stardust CrusaderZ

GOUZON Alexis programmateur systeme
RAKOTOMALALA Gaetan programmateur IHM
SHERMAN Nathaniel Concepteur
TECHER Antoine Artiste

Musique libre de droit provenant du site DL Sounds

Effet sonore libre de droit provenant des sites
- GR Sites
- Free Sound
- Sound Bible

Images libre de droit provenant des site
- Open Game Art
- Pexels

=end
