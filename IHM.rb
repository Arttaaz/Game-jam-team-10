require 'gosu'
load 'Player.rb'


class IHM < Gosu::Window

  def initialize(x,y, player)
    @x = x
    @y = y
    @font = Gosu::Font.new(20)
    @player = player
  end

  def draw
    self.box
  end

  def update(x,y)
    @x = x
    @y = y
  end

  def box
    draw_rect(@x+465,@y+455,610,290,Gosu::Color::BLACK, z=0, :default)
    draw_rect(@x+100,@y+455,70,70,Gosu::Color::WHITE, z=0, :default)
    draw_rect(@x+190,@y+455,70,70,Gosu::Color::WHITE, z=0, :default)
    draw_rect(@x+280,@y+455,70,70,Gosu::Color::WHITE, z=0, :default)
    draw_rect(@x+370,@y+455,70,70,Gosu::Color::WHITE, z=0, :default)

    @font.draw(@player.class,  @x-90, @y+455, 1, 2.0, 2.0, Gosu::Color::BLUE)
    @font.draw(@player.race,  @x-90, @y+490, 1, 2.0, 2.0, Gosu::Color::BLUE)

    @font.draw("Bouclier: " + @player.shield.to_s,  @x-90, @y+550, 1, 1.0, 1.0, Gosu::Color::CYAN)
    @font.draw("Santé: " + @player.health.to_s,  @x-90, @y+570, 1, 1.0, 1.0, Gosu::Color::RED)

    @font.draw("Dégâts: " + @player.damage.to_s,  @x-90, @y+620, 1, 1.0, 1.0, Gosu::Color::BLACK)
    @font.draw("Déf. physique: " + @player.phy_def.to_s,  @x-90, @y+650, 1, 1.0, 1.0, Gosu::Color::BLACK)
    @font.draw("Déf. énergie: " + @player.eng_def.to_s,  @x-90, @y+680, 1, 1.0, 1.0, Gosu::Color::BLACK)
    @font.draw("Vitesse: " + @player.speed.to_s,  @x-90, @y+710, 1, 1.0, 1.0, Gosu::Color::BLACK)

    @font.draw("Liste d'objets",  @x+200, @y+540, 1, 1.0, 1.0, Gosu::Color::FUCHSIA)

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
