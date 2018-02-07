require 'gosu'
load 'Player.rb'


class Item

  def initialize(name, image, type)
    @name = name
    @image = image
    @player = player

  end

  def useItem(name)
    case(name)
    when "Armure regenerante"

    when "Armure vivante"
    when "BFK"
    when "Bouclier energetique"
    when "Chalumeau"
    when "Cheveu divin"
    when "Combinaison spatiale"
    when "Couteau mortel"
    when "Cyber-cerveau"
    when "Epee plasmique"
    when "Gilet pare-balle"
    when "Katana"
    when "Lampe bleue"
    when "Magnum 50mm"
    when "Pistolet laser"
    when "Pistolet sonique"
    when "Tablier de cuisine"
    when "Tournevis sonique"
    when "Uniforme de pilote"
    when "Yeux de perception"
    end

  end

end

=begin
methode useItem(nom)

nom image use chomp separator "_"

mettre méthode dans player pour faire genre @player.useItem(nomItem)

=end
