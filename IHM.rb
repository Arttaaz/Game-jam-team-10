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
    @carte = Button.new("Carte", @x-100,@y+350,130,50,Gosu::Color::WHITE, @font)
    @stats = Button.new("Stats", @x+35,@y+350,130,50,Gosu::Color::WHITE, @font)
    @skills = Button.new("Capacites", @x+170,@y+350,130,50,Gosu::Color::WHITE, @font)
    @box = 0
  end

  def draw
    @carte.draw
    @stats.draw
    @skills.draw

    self.box
  end

  def update(x,y, player)
    @x = x
    @y = y
    @player = player
    @carte.update(x-100, y+350)
    @stats.update(x+35, y+350)
    @skills.update(x+170, y+350)
  end

  def click(x, y, xx, yy)
    @box = 0 if @carte.isInside?(x, y, xx, yy) == true
    @box = 1 if @stats.isInside?(x, y, xx, yy) == true
    @box = 2 if @skills.isInside?(x, y, xx, yy) == true
  end

  def box
=begin
    draw_rect(@x+100,@y+455,70,70,Gosu::Color::WHITE, z=0, :default)
    draw_rect(@x+190,@y+455,70,70,Gosu::Color::WHITE, z=0, :default)
    draw_rect(@x+280,@y+455,70,70,Gosu::Color::WHITE, z=0, :default)
    draw_rect(@x+370,@y+455,70,70,Gosu::Color::WHITE, z=0, :default)
    @font.draw(@player.class,  @x-90, @y+455, 1, 2.0, 2.0, Gosu::Color::BLUE)
    @font.draw(@player.race,  @x-90, @y+490, 1, 2.0, 2.0, Gosu::Color::BLUE)
=end





=begin
    @font.draw("Dégâts: " + @player.damage.to_s,  @x-90, @y+620, 1, 1.0, 1.0, Gosu::Color::BLACK)
    @font.draw("Déf. physique: " + @player.phy_def.to_s,  @x-90, @y+650, 1, 1.0, 1.0, Gosu::Color::BLACK)
    @font.draw("Déf. énergie: " + @player.eng_def.to_s,  @x-90, @y+680, 1, 1.0, 1.0, Gosu::Color::BLACK)
    @font.draw("Vitesse: " + @player.speed.to_s,  @x-90, @y+710, 1, 1.0, 1.0, Gosu::Color::BLACK)
    @font.draw("Liste d'objets",  @x+200, @y+540, 1, 1.0, 1.0, Gosu::Color::FUCHSIA)
=end

    case(@box)
    when 0 #carte
      draw_rect(@x+465,@y+355,610,290,Gosu::Color::BLACK, z=0, :default) #mini map

=begin # mode combat
      @font.draw("Sacha", @x, @y+440, 1, 1.5,1.5 , Gosu::Color::BLACK)

      draw_rect(@x+90,@y+430,60,60,Gosu::Color::WHITE, z=0, :default) #skills
      draw_rect(@x+165,@y+430,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+240,@y+430,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+315,@y+430,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+390,@y+430,60,60,Gosu::Color::WHITE, z=0, :default)

      draw_rect(@x+90,@y+505,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+165,@y+505,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+240,@y+505,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+315,@y+505,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+390,@y+505,60,60,Gosu::Color::WHITE, z=0, :default)

      draw_rect(@x+90,@y+580,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+165,@y+580,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+240,@y+580,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+315,@y+580,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+390,@y+580,60,60,Gosu::Color::WHITE, z=0, :default)
=end
      @font.draw("Santé: " + @player.health.to_s + "/" + @player.maxHealth.to_s,  @x+100, @y+410, 1, 1.0, 1.0, Gosu::Color::GREEN)
      @font.draw("Bouclier: " + @player.shield.to_s + "/" + @player.maxShield.to_s,  @x+100, @y+440, 1, 1.0, 1.0, Gosu::Color::CYAN)

      @font.draw("Dégâts: " + @player.damage.to_s,  @x-90, @y+410, 1, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw("Déf. physique: " + @player.phy_def.to_s,  @x-90, @y+440, 1, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw("Déf. énergie: " + @player.eng_def.to_s,  @x-90, @y+470, 1, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw("Vitesse: " + @player.speed.to_s,  @x-90, @y+500, 1, 1.0, 1.0, Gosu::Color::BLACK)

      draw_rect(@x-90,@y+550,60,60,Gosu::Color::WHITE, z=0, :default)
      @font.draw("Objet 1", @x+20, @y+565, 1, 1.5,1.5 , Gosu::Color::BLACK)
      draw_rect(@x+190,@y+550,60,60,Gosu::Color::WHITE, z=0, :default)
      @font.draw("Objet 2", @x+290, @y+565, 1, 1.5,1.5 , Gosu::Color::BLACK)

    when 1 # stats
      d=0
      3.times do
      @font.draw("Santé: " + @player.health.to_s + "/" + @player.maxHealth.to_s,  @x+d-90, @y+410, 1, 1.0, 1.0, Gosu::Color::GREEN)
      @font.draw("Bouclier: " + @player.shield.to_s + "/" + @player.maxShield.to_s,  @x+d-90, @y+430, 1, 1.0, 1.0, Gosu::Color::CYAN)
      @font.draw("Pouvoir: " + @player.power.to_s + "/" + @player.maxPower.to_s,  @x+d-90, @y+450, 1, 1.0, 1.0, Gosu::Color::FUCHSIA)
      @font.draw("Régén. pouvoir: " + @player.powRegen.to_s,  @x+d-90, @y+470, 1, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw("Classe: " + @player.class,  @x+d+90, @y+410, 1, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw("Race: " + @player.race,  @x+d+90, @y+430, 1, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw("Dégâts: " + @player.damage.to_s,  @x+d-90, @y+490, 1, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw("Réduc. dégâts: " + @player.dmgReduc.to_s + "%",  @x+d-90, @y+510, 1, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw("Déf. physique: " + @player.phy_def.to_s,  @x+d-90, @y+530, 1, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw("Déf. énergie: " + @player.eng_def.to_s,  @x+d-90, @y+550, 1, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw("Vitesse: " + @player.speed.to_s,  @x+d+90, @y+450, 1, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw("Argent: " + @player.money.to_s,  @x+d+90, @y+470, 1, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw("Bonus argent: " + @player.moneyBonus.to_s + "%",  @x+d+90, @y+490, 1, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw("Expérience: " + @player.exp.to_s,  @x+d+90, @y+510, 1, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw("Bonus exp: " + @player.expBonus.to_s + "%",  @x+d+90, @y+530, 1, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw("Nom", @x+d+20, @y+590, 1, 1.7,1.7 , Gosu::Color::BLUE)
      d=d+420
      end
    when 2 # skills
      @font.draw("Acvtives",  @x+258, @y+403, 1, 1.3, 1.3, Gosu::Color::BLACK)

      draw_rect(@x+120,@y+430,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+195,@y+430,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+270,@y+430,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+345,@y+430,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+420,@y+430,60,60,Gosu::Color::WHITE, z=0, :default)

      draw_rect(@x+120,@y+505,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+195,@y+505,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+270,@y+505,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+345,@y+505,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+420,@y+505,60,60,Gosu::Color::WHITE, z=0, :default)

      draw_rect(@x+120,@y+580,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+195,@y+580,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+270,@y+580,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+345,@y+580,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+420,@y+580,60,60,Gosu::Color::WHITE, z=0, :default)

      @font.draw("Passives",  @x+750, @y+403, 1, 1.3, 1.3, Gosu::Color::BLACK)

      draw_rect(@x+612,@y+430,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+687,@y+430,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+762,@y+430,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+837,@y+430,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+912,@y+430,60,60,Gosu::Color::WHITE, z=0, :default)

      draw_rect(@x+612,@y+505,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+687,@y+505,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+762,@y+505,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+837,@y+505,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+912,@y+505,60,60,Gosu::Color::WHITE, z=0, :default)

      draw_rect(@x+612,@y+580,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+687,@y+580,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+762,@y+580,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+837,@y+580,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+912,@y+580,60,60,Gosu::Color::WHITE, z=0, :default)
    end

  end

end

=begin
3 onglets
Carte:  - gauche: interface combat avec skills
      - droite: mini mini-map
stats:  stats des trois monsieurs placées coat à coat
Capacités (grisés pour ceux qui sont pas débloqués): - gauche: skills
                                                  - droite: passifs
=end
