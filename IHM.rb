require 'gosu'
load 'Player.rb'
load 'Button.rb'


class IHM < Gosu::Window

  def initialize(x,y, player)
    @x = x
    @y = y
    @font = Gosu::Font.new(20)
    @player = player
    @carte = Button.new("Carte", @x-100,@y+350,130,50,Gosu::Color::WHITE, @font)
    @stats = Button.new("Stats", @x+35,@y+350,130,50,Gosu::Color::WHITE, @font)
    @skills = Button.new("Capacites", @x+170,@y+350,130,50,Gosu::Color::WHITE, @font)
    @objects = Button.new("Objets", @x+305,@y+350,130,50,Gosu::Color::WHITE, @font)
  end

  def draw
    self.box
  end

  def update(x,y)
    @x = x
    @y = y
    @carte.update(x-100, y+350)
    @stats.update(x+35, y+350)
    @skills.update(x+170, y+350)
    @objects.update(x+305, y+350)
  end

  def click(x, y, xx, yy)
    @carte.isInside?(x, y, xx, yy)
    @stats.isInside?(x, y, xx, yy)
    @skills.isInside?(x, y, xx, yy)
    @objects.isInside?(x, y, xx, yy)
  end

  def box
    draw_rect(@x+465,@y+355,610,290,Gosu::Color::BLACK, z=0, :default)
=begin
    draw_rect(@x+100,@y+455,70,70,Gosu::Color::WHITE, z=0, :default)
    draw_rect(@x+190,@y+455,70,70,Gosu::Color::WHITE, z=0, :default)
    draw_rect(@x+280,@y+455,70,70,Gosu::Color::WHITE, z=0, :default)
    draw_rect(@x+370,@y+455,70,70,Gosu::Color::WHITE, z=0, :default)
    @font.draw(@player.class,  @x-90, @y+455, 1, 2.0, 2.0, Gosu::Color::BLUE)
    @font.draw(@player.race,  @x-90, @y+490, 1, 2.0, 2.0, Gosu::Color::BLUE)
=end

    @font.draw("Bouclier: " + @player.shield.to_s,  @x-90, @y+450, 1, 1.0, 1.0, Gosu::Color::CYAN)
    @font.draw("Santé: " + @player.health.to_s,  @x-90, @y+470, 1, 1.0, 1.0, Gosu::Color::RED)
=begin
    draw_rect(@x-100,@y+450,130,50,Gosu::Color::WHITE, 0, :default)
    draw_rect(@x+35,@y+450,130,50,Gosu::Color::WHITE, 0, :default)
    draw_rect(@x+170,@y+450,130,50,Gosu::Color::WHITE, 0, :default)
    draw_rect(@x+305,@y+450,130,50,Gosu::Color::WHITE, 0, :default)
    @font.draw("Carte",@x-70,@y+460, 2, 1.5, 1.5 ,Gosu::Color::BLACK)
    @font.draw("Stats",@x+70,@y+460, 2, 1.5, 1.5 ,Gosu::Color::BLACK)
    @font.draw("Capacités",@x+175,@y+460, 2, 1.5, 1.5 ,Gosu::Color::BLACK)
    @font.draw("Objets",@x+325,@y+460, 2, 1.5, 1.5 ,Gosu::Color::BLACK)
=end

    @carte.draw
    @stats.draw
    @skills.draw
    @objects.draw

=begin
    @font.draw("Dégâts: " + @player.damage.to_s,  @x-90, @y+620, 1, 1.0, 1.0, Gosu::Color::BLACK)
    @font.draw("Déf. physique: " + @player.phy_def.to_s,  @x-90, @y+650, 1, 1.0, 1.0, Gosu::Color::BLACK)
    @font.draw("Déf. énergie: " + @player.eng_def.to_s,  @x-90, @y+680, 1, 1.0, 1.0, Gosu::Color::BLACK)
    @font.draw("Vitesse: " + @player.speed.to_s,  @x-90, @y+710, 1, 1.0, 1.0, Gosu::Color::BLACK)
    @font.draw("Liste d'objets",  @x+200, @y+540, 1, 1.0, 1.0, Gosu::Color::FUCHSIA)
=end

  end


end

=begin
4 onglets
Carte:  - gauche: interface combat avec skills
      - droite: mini mini-map
stats:  stats des trois monsieurs placées coat à coat
Capacités (grisés pour ceux qui sont pas débloqués): - gauche: skills
                                                  - droite: passifs
Objets:  - gauche: items portés actuellement par les personnages
        - droite: inventaire
=end
