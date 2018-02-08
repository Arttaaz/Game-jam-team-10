require 'gosu'

class Log < Gosu::Window

  attr_reader :message

  def initialize(x,y)
    @x = x
    @y = y
    @lignes = ["Salut toi dis-donc",
      "Ce négro il attaque ce méchant ouille ouille il a mal",
      "oooooooooooooooooooooooooooooooooooooooooooooooooo",
      "Jean Quille attaque Hervé Blanchon avec Nom du skill hoho et cause 33 dégâts",
      "Jean Quille attaque Hervé Blanchon avec Nom du skill hoho et cause 33 dégâts",
      "Jean Quille attaque Hervé Blanchon avec Nom du skill hoho et cause 33 dégâts",
      "Jean Quille attaque Hervé Blanchon avec Nom du skill hoho et cause 33 dégâts",
      "Jean Quille attaque Hervé Blanchon avec Nom du skill hoho et cause 33 dégâts",
      "Jean Quille attaque Hervé Blanchon avec Nom du skill hoho et cause 33 dégâts",
      "Jean Quille attaque Hervé Blanchon avec Nom du skill hoho et cause 33 dégâts",
      "Jean Quille attaque Hervé Blanchon avec Nom du skill hoho et cause 33 dégâts",
      "Jean Quille attaque Hervé Blanchon avec Nom du skill hoho et cause 33 dégâts",
      "Jean Quille attaque Hervé Blanchon avec Nom du skill hoho et cause 33 dégâts",
      "Jean Quille attaque Hervé Blanchon avec Nom du skill hoho et cause 33 dégâts",
      "Jean Quille attaque Hervé Blanchon avec Nom du skill hoho et cause 33 dégâts",
      "Jean Quille attaque Hervé Blanchon avec Nom du skill hoho et cause 33 dégâts",
      "Jean Quille attaque Hervé Blanchon avec Nom du skill hoho et cause 33 dégâts",
      "Jean Quille attaque Hervé Blanchon avec Nom du skill hoho et cause 33 dégâts",
      "Jean Quille attaque Hervé Blanchon avec Nom du skill hoho et cause 33 dégâts"]
    @font = Gosu::Font.new(20)
  end

  def addLine(message)
    @lignes << message
    if @lignes[19].nil? == false
      @lignes.delete_at(0)
    end
  end

  def update(x,y)
    @x = x
    @y = y
  end

  def dispLog
    d=0
    @lignes.each do |ligne|
      @font.draw(ligne, @x,@y+d, 1,0.8,0.8, Gosu::Color::WHITE)
      d+=15
    end
  end


end
