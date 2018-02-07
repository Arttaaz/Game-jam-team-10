require 'gosu'
load 'Player.rb'
load 'Button.rb'


class IHM < Gosu::Window

  def initialize(x,y, players, player)
    @x = x
    @y = y
    @font = Gosu::Font.new(20)
    @players = players
    @player = player
    @personnage = Button.new("Personnage", @x-100,@y+350,160,50,Gosu::Color::WHITE, @font)
    @stats = Button.new("Stats", @x+70,@y+350,150,50,Gosu::Color::WHITE, @font)
    @skills = Button.new("Capacités", @x+275,@y+350,150,50,Gosu::Color::WHITE, @font)
    @box = 0
  end

  def draw
    @personnage.draw
    @stats.draw
    @skills.draw

    self.box
  end

  def update(x,y, player)
    @x = x
    @y = y
    @player = player
    @personnage.update(x-100, y+350)
    @stats.update(x+70, y+350)
    @skills.update(x+230, y+350)
  end

  def click(x, y, xx, yy)
    @box = 0 if @personnage.isClicked?(x, y, xx, yy) == true
    @box = 1 if @stats.isClicked?(x, y, xx, yy) == true
    @box = 2 if @skills.isClicked?(x, y, xx, yy) == true
  end

  def box

    case(@box)
      when 0 #personnage
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

      when 1 # stats
        d=0
        @players.size.times do |n|
          @font.draw("Santé: " + @players[n].health.to_s + "/" + @players[n].maxHealth.to_s,  @x+d-90, @y+410, 1, 1.0, 1.0, Gosu::Color::GREEN)
          @font.draw("Bouclier: " + @players[n].shield.to_s + "/" + @players[n].maxShield.to_s,  @x+d-90, @y+430, 1, 1.0, 1.0, Gosu::Color::CYAN)
          @font.draw("Power: " + @players[n].power.to_s + "/" + @players[n].maxPower.to_s,  @x+d-90, @y+450, 1, 1.0, 1.0, Gosu::Color::FUCHSIA)
          @font.draw("Régén. power: " + @players[n].powRegen.to_s,  @x+d-90, @y+470, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Classe: " + @players[n].class,  @x+d+90, @y+410, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Race: " + @players[n].race,  @x+d+90, @y+430, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Dégâts: " + @players[n].damage.to_s,  @x+d-90, @y+490, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Réduc. dégâts: " + @players[n].dmgReduc.to_s + "%",  @x+d-90, @y+510, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Déf. physique: " + @players[n].phy_def.to_s,  @x+d-90, @y+530, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Déf. énergie: " + @players[n].eng_def.to_s,  @x+d-90, @y+550, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Vitesse: " + @players[n].speed.to_s,  @x+d+90, @y+450, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Argent: " + @players[n].money.to_s,  @x+d+90, @y+470, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Bonus argent: " + @players[n].moneyBonus.to_s + "%",  @x+d+90, @y+490, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Expérience: " + @players[n].exp.to_s,  @x+d+90, @y+510, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Bonus exp: " + @players[n].expBonus.to_s + "%",  @x+d+90, @y+530, 1, 1.0, 1.0, Gosu::Color::BLACK)
          @font.draw("Nom", @x+d+20, @y+590, 1, 1.7,1.7 , Gosu::Color::BLUE)
        d=d+420
        end
      when 2 # skills
        @font.draw("Acvtives",  @x+258, @y+403, 1, 1.3, 1.3, Gosu::Color::BLACK)
        @font.draw("Passives",  @x+750, @y+403, 1, 1.3, 1.3, Gosu::Color::BLACK)
=begin
parcourir les différents arrays contenus dans l'array skills
regarder le Type genre @players[n].skills[i][0]
si Type::ACTIVE faire affichage à gauche
sinon à droite
=end
        dx=dy=0
        @players.size.times do |n|
          @font.draw(@players[n].name, @x-90, @y+dy+440, 1, 1.7,1.7 , Gosu::Color::BLUE)
          @players[n].skills.each do |skill|
            case(skill[n])
            when Type::ACTIVE
              draw_rect(@x+dx+120,@y+dy+430,60,60,Gosu::Color::WHITE, z=0, :default)
            when Type::PASSIVE
              draw_rect(@x+dx+612,@y+dy+430,60,60,Gosu::Color::WHITE, z=0, :default)
            end
            dx=dx+75
          end
          dy=dy+75
        end

      end
    end
end
