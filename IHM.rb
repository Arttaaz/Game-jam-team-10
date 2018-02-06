require 'gosu'
load 'Player.rb'
load 'Button.rb'


class IHM < Gosu::Window

  def initialize(x,y, players)
    @x = x
    @y = y
    @font = Gosu::Font.new(20)
    @players = players
    @carte = Button.new("Carte", @x-100,@y+450,130,50,Gosu::Color::WHITE, @font)
    @stats = Button.new("Stats", @x+35,@y+450,130,50,Gosu::Color::WHITE, @font)
    @skills = Button.new("Capacités", @x+170,@y+450,130,50,Gosu::Color::WHITE, @font)
    @objects = Button.new("Objets", @x+305,@y+450,130,50,Gosu::Color::WHITE, @font)
  end

  def draw
    self.box
    self.tabContent(2) # paramètre (tabName) ?
  end

  def update(x,y)
    @x = x
    @y = y
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

    @font.draw("Bouclier: " + @players[0].shield.to_s + "/" + @players[0].maxShield.to_s,  @x-90, @y+550, 1, 1.0, 1.0, Gosu::Color::CYAN)
    @font.draw("Santé: " + @players[0].health.to_s + "/" + @players[0].maxHealth.to_s,  @x-90, @y+570, 1, 1.0, 1.0, Gosu::Color::RED)

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

  def tabContent(tab)#(tabName)
    if tab==1 #(tabName == @tabs[0]) #carte
      draw_rect(@x+465,@y+455,610,290,Gosu::Color::BLACK, z=0, :default) #carte

      draw_rect(@x+90,@y+535,60,60,Gosu::Color::WHITE, z=0, :default) #skills
      draw_rect(@x+165,@y+535,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+240,@y+535,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+315,@y+535,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+390,@y+535,60,60,Gosu::Color::WHITE, z=0, :default)

      draw_rect(@x+90,@y+610,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+165,@y+610,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+240,@y+610,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+315,@y+610,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+390,@y+610,60,60,Gosu::Color::WHITE, z=0, :default)

      draw_rect(@x+90,@y+685,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+165,@y+685,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+240,@y+685,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+315,@y+685,60,60,Gosu::Color::WHITE, z=0, :default)
      draw_rect(@x+390,@y+685,60,60,Gosu::Color::WHITE, z=0, :default)
    elsif tab == 2#(tabName == @tabs[1]) #Stats
      @font.draw("Dégâts: " + @players[0].damage.to_s,  @x-90, @y+620, 1, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw("Déf. physique: " + @players[0].phy_def.to_s,  @x-90, @y+650, 1, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw("Déf. énergie: " + @players[0].eng_def.to_s,  @x-90, @y+680, 1, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw("Vitesse: " + @players[0].speed.to_s,  @x-90, @y+710, 1, 1.0, 1.0, Gosu::Color::BLACK)
    #elsif #(tabName == @tabs[2]) #Capacités

    #else #Objets

    end
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
