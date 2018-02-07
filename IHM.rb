require 'gosu'
load 'Player.rb'
load 'Button.rb'


class IHM < Gosu::Window

  def initialize(x,y, players, enemies, player, fighting)
    @x = x
    @y = y
    @font = Gosu::Font.new(20)
    @enemies = enemies
    @players = players
    @player = player
    @personnage = Button.new("Personnage", @x-100,@y+350,160,50,Gosu::Color::WHITE, @font)
    @stats = Button.new("Stats", @x+70,@y+350,150,50,Gosu::Color::WHITE, @font)
    @skills = Button.new("Capacités", @x+275,@y+350,150,50,Gosu::Color::WHITE, @font)
    @box = 0
    @fighting = fighting
    @waitTarget = false
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
  end

  def click(x, y, xx, yy)
    @box = 0 if @personnage.isClicked?(x, y, xx, yy) == true
    @box = 1 if @stats.isClicked?(x, y, xx, yy) == true
    @box = 2 if @skills.isClicked?(x, y, xx, yy) == true
    if @waitTarget
      if @pendingSkill[0] == Type::SELF
        @pendingSkill[1].target = @player
        @player.power -= @pendingSkill[1].activate
      elsif @pendingSkill[0] == Type::ALLIES
        @pendingSkill[1].target = @players
        @player.power -= @pendingSkill[1].activate
      elsif @pendingSkill[0] == Type::ENEMIES
        @pendingSkill[1].target = @enemies
        @player.power -= @pendingSkill[1].activate
      else
        @players.each { |p|
          if p.isClicked?(x, y, xx)
            case @pendingSkill[0]
            when Type::ALLY
              @pendingSkill[1].target = p
              @player.power -= @pendingSkill[1].activate
            end
          end
        }
        @enemies.each { |e|
          if e.isClicked?(x, y, xx)
            case @pendingSkill[0]
            when Type::ENEMY
              @pendingSkill[1].target = e
              @player.power -= @pendingSkill[1].activate
            end
          end
        }
      end
    end
  end

  def dispSkills

  end

  def box

    case(@box)
      when 0 #personnage
      if @fighting==true
        draw_rect(@x+465,@y+355,610,290,Gosu::Color::BLACK, z=0, :default) #mini map

        @font.draw("Santé: " + @player.health.to_s + "/" + @player.maxHealth.to_s,  @x-90, @y+410, 1, 1.0, 1.0, Gosu::Color::GREEN)
        @font.draw("Bouclier: " + @player.shield.to_s + "/" + @player.maxShield.to_s,  @x-90, @y+440, 1, 1.0, 1.0, Gosu::Color::CYAN)
        @font.draw("Power: " + @player.power.to_s + "/" + @player.maxPower.to_s,  @x-90, @y+470, 1, 1.0, 1.0, Gosu::Color::FUCHSIA)

        @font.draw("Dégâts: " + @player.damage.to_s,  @x+100, @y+410, 1, 1.0, 1.0, Gosu::Color::BLACK)
        @font.draw("Déf. physique: " + @player.phy_def.to_s,  @x+100, @y+440, 1, 1.0, 1.0, Gosu::Color::BLACK)
        @font.draw("Déf. énergie: " + @player.eng_def.to_s,  @x+100, @y+470, 1, 1.0, 1.0, Gosu::Color::BLACK)
        @font.draw("Vitesse: " + @player.speed.to_s,  @x+100, @y+500, 1, 1.0, 1.0, Gosu::Color::BLACK)

        draw_rect(@x+250,@y+410,60,60,Gosu::Color::WHITE, z=0, :default)
        @font.draw("Objet 1", @x+330, @y+425, 1, 1.5,1.5 , Gosu::Color::BLACK)
        draw_rect(@x+250,@y+480,60,60,Gosu::Color::WHITE, z=0, :default)
        @font.draw("Objet 2", @x+330, @y+495, 1, 1.5,1.5 , Gosu::Color::BLACK)

        dx=0
        @player.skills.each do |skill|
          if skill[0]==Type::ACTIVE
            draw_rect(@x+dx-90,@y+550,60,60,Gosu::Color::WHITE, z=0, :default)
            dx=dx+75
          end
        end

        @font.draw(@player.name, @x-90, @y+615, 1, 1.7,1.7 , Gosu::Color::BLUE)
      else
        draw_rect(@x+465,@y+355,610,290,Gosu::Color::BLACK, z=0, :default) #mini map

        @font.draw("Santé: " + @player.health.to_s + "/" + @player.maxHealth.to_s,  @x-90, @y+410, 1, 1.0, 1.0, Gosu::Color::GREEN)
        @font.draw("Bouclier: " + @player.shield.to_s + "/" + @player.maxShield.to_s,  @x-90, @y+440, 1, 1.0, 1.0, Gosu::Color::CYAN)
        @font.draw("Power: " + @player.power.to_s + "/" + @player.maxPower.to_s,  @x-90, @y+470, 1, 1.0, 1.0, Gosu::Color::FUCHSIA)

        @font.draw("Dégâts: " + @player.damage.to_s,  @x+100, @y+410, 1, 1.0, 1.0, Gosu::Color::BLACK)
        @font.draw("Déf. physique: " + @player.phy_def.to_s,  @x+100, @y+440, 1, 1.0, 1.0, Gosu::Color::BLACK)
        @font.draw("Déf. énergie: " + @player.eng_def.to_s,  @x+100, @y+470, 1, 1.0, 1.0, Gosu::Color::BLACK)
        @font.draw("Vitesse: " + @player.speed.to_s,  @x+100, @y+500, 1, 1.0, 1.0, Gosu::Color::BLACK)

        draw_rect(@x-90,@y+550,60,60,Gosu::Color::WHITE, z=0, :default)
        @font.draw("Objet 1", @x+20, @y+565, 1, 1.5,1.5 , Gosu::Color::BLACK)
        draw_rect(@x+190,@y+550,60,60,Gosu::Color::WHITE, z=0, :default)
        @font.draw("Objet 2", @x+290, @y+565, 1, 1.5,1.5 , Gosu::Color::BLACK)

        @font.draw(@player.name, @x-90, @y+615, 1, 1.7,1.7 , Gosu::Color::BLUE)
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
          @font.draw(@players[n].name, @x+d+5, @y+590, 1, 1.7,1.7 , Gosu::Color::BLUE)
        d=d+420
        end
      when 2 # skills
        @font.draw("Actives",  @x+258, @y+403, 1, 1.3, 1.3, Gosu::Color::BLACK)
        @font.draw("Passives",  @x+750, @y+403, 1, 1.3, 1.3, Gosu::Color::BLACK)
        dy=0
        @players.size.times do |n|
          dxa=dxp=0
          @font.draw(@players[n].name, @x-90, @y+dy+445, 1, 1.3,1.3 , Gosu::Color::BLUE)
          @players[n].skills.each do |skill|
            case(skill[0])
            when Type::ACTIVE
              draw_rect(@x+dxa+120,@y+dy+430,60,60,Gosu::Color::WHITE, z=0, :default)
              dxa=dxa+75
            when Type::PASSIVE
              draw_rect(@x+dxp+612,@y+dy+430,60,60,Gosu::Color::WHITE, z=0, :default)
              dxp=dxp+75
            end
          end
          dy=dy+75
        end
      end
    end
end
