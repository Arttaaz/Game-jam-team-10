require 'gosu'
load 'Skill.rb'

$SkillList = [
  [Type::ACTIVE, Dmg.new("Attaque", Type::ACTIVE, Who::ENEMY, 100, "assets/Skills/Attaque.png")],
  [Type::PASSIVE, MaxPowerModif.new("Libre arbitre", Type::PASSIVE, Who::SELF, 25, "assets/Skills/Races/Humain/1_Libre_arbitre.png")],
  [Type::ACTIVE, DmgModif.new("Concentration", Type::ACTIVE, Who::SELF, 25, "assets/Skills/Races/Humain/2_Concentration.png", 30, 2, true)],
  [Type::PASSIVE, Heal.new("Auto-reparateur", Type::PASSIVE, Who::SELF, 25, "assets/Skills/Races/Robot/1_Auto-repaire.png")],
  [Type::ACTIVE, SpeedModif.new("Taser", Type::ACTIVE, Who::ENEMY, 9000, "assets/Skills/Races/Robot/2_Taser.png", 34, 1, true)],
  [Type::PASSIVE, DmgModif.new("Volonte de fer", Type::PASSIVE, Who::SELF, 10, "assets/Skills/Classes/Soldat/01-1_Volontee_de_fer.png")],
  [Type::ACTIVE, Dmg.new("Tire puissant", Type::ACTIVE, Who::ENEMY, 120, "assets/Skills/Classes/Soldat/01-2_Tire_puissant.png", 34, 0, false, DmgType::PHYS)],
  [Type::PASSIVE, DmgModif.new("Munition lourde", Type::PASSIVE, Who::SELF, 15, "assets/Skills/Classes/Soldat/03-1_Munition_lourde.png")],
  [Type::PASSIVE, PowerRegenModif.new("Vigeur", Type::PASSIVE, Who::SELF, 15, "assets/Skills/Classes/Soldat/03-2_Vigeur.png")],
  [Type::ACTIVE, Dmg.new("Grenade militaire", Type::ACTIVE, Who::ENEMIES, 70, "assets/Skills/Classes/Soldat/06-1_Grenade_militaire.png", 44, 0, false, DmgType::PHYS)],
  [Type::ACTIVE, Dmg.new("Grenade photonique", Type::ACTIVE, Who::ENEMIES, 70, "assets/Skills/Classes/Soldat/06-2_Grenade_photonique.png", 44, 0, false, DmgType::ENG)],
  [Type::PASSIVE, DmgModif.new("Expert d'arme", Type::PASSIVE, Who::SELF, 20, "assets/Skills/Classes/Soldat/09-1_Expert_d'arme.png")],
  [Type::PASSIVE, PowerRegenModif.new("Determination", Type::PASSIVE, Who::SELF, 25, "assets/Skills/Classes/Soldat/09-2_Determination.png")],
  [Type::ACTIVE, Dmg.new("Coutean militaire", Type::ACTIVE, Who::ENEMY, 40, "assets/Skills/Classes/Soldat/12-1_Couteau_militaire.png", 34, 3, true, DmgType::PHYS)],
  [Type::ACTIVE, Dmg.new("Lame plasmique", Type::ACTIVE, Who::ENEMY, 120, "assets/Skills/Classes/Soldat/12-2_Lame_plasmique.png", 34, 0, false, DmgType::ENG)],
  [Type::PASSIVE, PhysDefModif.new("Vulnerabilite physique", Type::PASSIVE, Who::ENEMIES, -20, "assets/Skills/Classes/Soldat/15-1_Vulnerabilite_physique.png")],
  [Type::PASSIVE, EngDefModif.new("Vulnerabilite energetique", Type::PASSIVE, Who::ENEMIES, -20, "assets/Skills/Classes/Soldat/15-2_Vulnerabilite_energetique.png")],
  [Type::ACTIVE, Dmg.new("Shotgun", Type::ACTIVE, Who::ENEMIES, 150, "assets/Skills/Classes/Soldat/18-1_Shotgun.png", 80, 0, false, DmgType::PHYS)],
  [Type::ACTIVE, Dmg.new("Railgun", Type::ACTIVE, Who::ENEMY, 350, "assets/Skills/Classes/Soldat/18-2_Railgun.png", 80, 0, false, DmgType::ENG)],
  [Type::PASSIVE, ExpModif.new("Connaissance", Type::PASSIVE, Who::ALLIES, 10, "assets/Skills/Classes/Scientifique/01-1_Connaissance.png")],
  [Type::ACTIVE, ResModif.new("Analyse", Type::ACTIVE, Who::ENEMY, -15, "assets/Skills/Classes/Scientifique/01-2_Analyse.png", 20, 3, true)],
  [Type::PASSIVE, Heal.new("Placebo", Type::PASSIVE, Who::ALLIES, 5, "assets/Skills/Classes/Scientifique/03-1_Placebo.png")],
  [Type::PASSIVE, ResModif.new("Vapeur nefaste", Type::PASSIVE, Who::ENEMIES, -10, "assets/Skills/Classes/Scientifique/03-2_Vapeur_nefaste.png")],
  [Type::ACTIVE, Heal.new("Soin", Type::ACTIVE, Who::ALLY, 80, "assets/Skills/Classes/Scientifique/06-1_Soin.png", 60)],
  [Type::ACTIVE, Dmg.new("Cocktail chimique", Type::ACTIVE, Who::ENEMIES, 20, "assets/Skills/Classes/Scientifique/06-2_Cocktail_chimique.png", 40, 3, true, DmgType::ENG)],
  [Type::PASSIVE, SpeedModif.new("Vitesse", Type::PASSIVE, Who::ALLIES, 3, "assets/Skills/Classes/Scientifique/09-1_Vitesse.png")],
  [Type::PASSIVE, DmgModif.new("Prevoyance", Type::PASSIVE, Who::ENEMIES, -15, "assets/Skills/Classes/Scientifique/09-2_Prevoyance.png")],
  [Type::ACTIVE, Heal.new("Medicament", Type::ACTIVE, Who::ALLY, 15, "assets/Skills/Classes/Scientifique/12-1_Medicament.png", 64, 5, true)],
  [Type::ACTIVE, ResModif.new("Faiblesse", Type::ACTIVE, Who::ENEMY, -50, "assets/Skills/Classes/Scientifique/12-2_Faiblesse.png", 56, 1, true)],
  [Type::PASSIVE, ResModif.new("Resistance", Type::PASSIVE, Who::ALLIES, 15, "assets/Skills/Classes/Scientifique/15-1_Resistance.png")],
  [Type::PASSIVE, SpeedModif.new("Ralentissement", Type::PASSIVE, Who::ENEMIES, 5, "assets/Skills/Classes/Scientifique/15-2_ralentissement.png")],
  [Type::ACTIVE, Heal.new("Soin de masse", Type::ACTIVE, Who::ALLIES, 200, "assets/Skills/Classes/Scientifique/18-1_Soin_de_masse.png", 100)],
  [Type::ACTIVE, SpeedModif.new("Grenade flash", Type::ACTIVE, Who::ENEMIES, 9000, "assets/Skills/Classes/Scientifique/18-2_Grenade_flash.png", 90, 1, true)],
  [Type::PASSIVE, PowerRegenModif.new("Endurance", Type::PASSIVE, Who::ALLIES, 35, "assets/Skills/Classes/Ingenieur/01-1_Endurance.png")],
  [Type::ACTIVE, ResModif.new("Assistance", Type::ACTIVE, Who::ALLY, 35, "assets/Skills/Classes/Ingenieur/01-2_Assistance.png", 52, 2, true)],
  [Type::PASSIVE, ResModif.new("Adaptation", Type::PASSIVE, Who::SELF, 15, "assets/Skills/Classes/Ingenieur/03-1_Adaptation.png")],
  [Type::PASSIVE, PowerRegenModif.new("Reparation", Type::PASSIVE, Who::ALLIES, 20, "assets/Skills/Classes/Ingenieur/03-2_Reparation.png")],
  [Type::ACTIVE, MaxHealthModif.new("Vitalite", Type::ACTIVE, Who::ALLY, 50, "assets/Skills/Classes/Ingenieur/06-1_Vitalite.png", 70, 8, true)],
  [Type::ACTIVE, ShieldModif.new("Restoration", Type::ACTIVE, Who::ALLY, 40, "assets/Skills/Classes/Ingenieur/06-2_Restoration.png", 44)],
  [Type::PASSIVE, MaxShieldModif.new("Redirection", Type::PASSIVE, Who::ALLIES, 20, "assets/Skills/Classes/Ingenieur/09-1_Redirection.png")],
  [Type::PASSIVE, DmgModif.new("Augmentation", Type::PASSIVE, Who::ALLIES, 10, "assets/Skills/Classes/Ingenieur/09-2_Augmentation.png")],
  [Type::ACTIVE, Heal.new("Super regeneration", Type::ACTIVE, Who::SELF, 10, "assets/Skills/Classes/Ingenieur/12-1_Super_regeneration.png", 84, 5, true)],
  [Type::ACTIVE, SpeedModif.new("Acceleration", Type::ACTIVE, Who::ALLIES, 7, "assets/Skills/Classes/Ingenieur/12-2_Acceleration.png", 60, 3, true)],
  [Type::PASSIVE, SpeedModif.new("Contre", Type::PASSIVE, Who::ENEMIES, 4, "assets/Skills/Classes/Ingenieur/15-1_Contre.png")],
  [Type::PASSIVE, ResModif.new("Armure renforcee", Type::PASSIVE, Who::ALLIES, 15, "assets/Skills/Classes/Ingenieur/15-2_Armure_renforcee.png")],
  [Type::ACTIVE, ResModif.new("Mastodonte", Type::ACTIVE, Who::SELF, 100, "assets/Skills/Classes/Ingenieur/18-1_Mastodonte.png", 100, 1, true)],
  [Type::ACTIVE, ShieldModif.new("Barriere", Type::ACTIVE, Who::ALLIES, 70, "assets/Skills/Classes/Ingenieur/18-2_Barriere.png", 110)]
]
#name, type, who, modifier, image, cost = 0, duration = 0, temp = false, dmgType = nil target = nil



class Player

  attr_reader :name, :level, :active, :x, :vel_x, :vel_y, :distance, :y, :health, :maxHealth, :maxPower, :power, :powRegen, :dmgReduc, :maxShield, :shield, :speed, :phy_def, :eng_def, :damage, :skills, :items, :class, :race, :exp, :expBonus, :reqExp
  attr_accessor :name, :active, :x, :vel_x, :vel_y, :distance, :y, :health, :maxHealth, :maxPower, :power, :powRegen, :dmgReduc, :maxShield, :shield, :speed, :phy_def, :eng_def, :damage, :skills, :items, :class, :race, :exp, :expBonus, :reqExp

  def initialize(x, y, race = "d")
    @skills = [] #array is like [ [active/passive, skill object], [active/passive, skill object]]
    @items = []
    @races = ["Humain", "Robot"]
    @@humanNames = ["Jony Phelley", "Patry Garcia", "Jesse Patte", "Randy Scotte", "Effreyne Johnson", "Joshua Hayeson", "Raymy Colly",
       "Wayne Hezal", "Mase Carte", "Willie Warte", "Romain Fecher", "Arttaaz", "AoRailgun", "Gathzen", "Elvung", "Jean Quille","Fujimaru",
       "Alexpert","Ken", "Jacquie", "Hervé Blanchon", "Jonathan Joestar", "Joseph Joestar",
       "Jotaro Kujo"]
    @@robotNames = ["Ash", "Shrimp", "Cylinder", "Andy Roid", "Onproid", "Otid", "Bit", "Screwie", "Rubber", "Corius", "Ulx",
       "Aja","Camzou38","DijTheWhite","Sweedix","Zorann","Azéris","Arxwell","Glubidi","Michel"]
    @classes = ["Soldat", "Scientifique", "Ingénieur"]
    @active = false
    @level = 1
    @image1, @image2 = nil
    @x = x
    @vel_x = 0
    @distance = 0 #distance moved
    @y = y
    @vel_y = 0
    @z = 1
    @dmgReduc = 0 #%
    @exp = 0
    @expBonus = 0 #%
    @race = race
    @race = @races[rand(0..1)] if @race == "d"
    if @race == "Humain"
      index = rand(@@humanNames.size)
      @name = @@humanNames[index]
      @@humanNames.delete_at(index)
      image = "assets/Characters/Humans/" + ["char.png", "var1.png", "var2.png", "var3.png", "var4.png"].shuffle!.first
      @image1, @image2 = *Gosu::Image.load_tiles(image, 200, 300, :tileable => true)
      @image = @image1
    elsif @race == "Robot"
      index = rand(@@robotNames.size)
      @name = @@robotNames[index]
      @@robotNames.delete_at(index)
      image = "assets/Characters/Robots/" + ["nicerobot.png"].shuffle!.first
      @image1,@image2 = *Gosu::Image.load_tiles(image, 200, 300, :tileable => true)
      @image = @image1
    else
      @name = ""
      image = "assets/Characters/Infested/" + ["Infested.png", "var1.png", "var2.png", "var3.png"].shuffle!.first
      @image = Gosu::Image.new(image, :tileable => true)
    end
    @class = @classes[rand(0..2)]
    redefStats(@race)
    gainSkill
    @color = 0xff_ffffff
    @reqExp = 15
  end

  def move(x,y)
    @x = @x + x
    @y = @y + y
  end

  def draw
    @image.draw(@x,@y,@z, 1, 1, @color)
    Gosu.draw_rect(x, y+300, 100, 10, Gosu::Color::BLACK, 4)
    Gosu.draw_rect(x, y+300, (@shield *100)/@maxShield, 10, Gosu::Color::CYAN, 4)
    Gosu.draw_rect(x, y+315, 100, 10, Gosu::Color::BLACK, 4)
    Gosu.draw_rect(x, y+315, (@health *100)/@maxHealth, 10, Gosu::Color::GREEN, 4)
    Gosu.draw_rect(x, y+330, 100, 10, Gosu::Color::BLACK, 4)
    Gosu.draw_rect(x, y+330, (@power *100)/@maxPower, 10, Gosu::Color::FUCHSIA, 4)
  end

  def update
    if @health <= 0
      @health = 0
      @shield = 0
      @power = 0
      @color = Gosu::Color::GRAY
      @active = false
    end
    if @shield <= 0
      @shield = 0
    end

    if @power <= 0
      @power = 0
    end

    @skills.each { |s|
      if @power < s[1].cost
        s[1].color = Gosu::Color::GRAY
      else
        s[1].color = 0xff_ffffff
      end
    }

    if @exp >= @reqExp
      self.levelup
      @reqExp+=15
    end

    if @vel_x != 0
      self.move(@vel_x, 0)
      @distance = @distance + @vel_x
      @image = (Gosu.milliseconds / 175 % 2 == 0) ? @image1 : @image2
      if @distance == 1200 || distance == -1200
        @distance = 0
        @vel_x = 0
        @image = @image1
      end
    elsif @vel_y != 0
      @z = -1
      self.move(0,@vel_y)
      @distance = @distance + @vel_y
      if @distance == 600 ||distance == -600
        @distance = 0
        @vel_y = 0
        @z = 1
      end
    end
  end

  def regen
    if @power+@powRegen < @maxPower
      @power += @powRegen
    else
      @power = @maxPower
    end
  end

  def regenRoom

    if @shield + 15 < @maxShield
      @shield += 15
    else
      @shield = @maxShield
    end

    if @power+2*@powRegen < @maxPower
      @power += 2*@powRegen
    else
      @power = @maxPower
    end
  end

  def redefStats(race)
    if @race == @races[0] #humain
      @maxHealth = @health = rand(100..200)
      @maxShield = @shield = rand(40..60)
      @maxPower = @power = 100
      @powRegen = 10
      @damage = rand(35..45)
      @phy_def = rand(8..12)
      @eng_def = rand(8..12)
      @speed = rand(12..18)
      @skills << $SkillList[0]
      @skills << $SkillList[1]
      @skills << $SkillList[2]
    elsif @race == @races[1] #robot
      @maxHealth = @health = rand(70..90)
      @maxShield = @shield = rand(70..90)
      @maxPower = @power = 120
      @powRegen = 12
      @damage = rand(45..60)
      @phy_def = rand(4..8)
      @eng_def = rand(6..12)
      @speed = rand(14..20)
      @skills << $SkillList[0]
      @skills << $SkillList[3]
      @skills << $SkillList[4]
    else #@race == @races[2]   infested
      @maxHealth = @health = rand(140..180)
      @maxShield = @shield = 0 #lààààààà c'est 000000
      @maxPower = @power = 80
      @powRegen = 8
      @damage = rand(20..30)
      @phy_def = rand(14..18)
      @eng_def = rand(10..14)
      @speed = rand(8..16)
    end
  end

  def levelup
    @level += 1
    gainSkill
    case(@race)
    when "Humain"
      @health += 20
      @maxHealth += 20
      @shield += 5
      @maxShield +=5
      @power += 10
      @maxPower += 10
      @powRegen += 2
      @damage += 5
      @phy_def += 2
      @eng_def += 2
      @speed += 1

    when "Robot"
      @health += 5
      @maxHealth += 5
      @shield += 20
      @maxShield += 20
      @power += 15
      @maxPower += 15
      @powRegen += 4
      @damage += 7
      @phy_def += 1
      @eng_def += 2
      @speed += 2
    end
  end

  def isClicked?(x, y, xx)
    if (x >= @x-xx+100) && (y >= 150)
      if (x <= @x-xx+210) && (y <= 450)
        return true
      else
        return false
      end
    end
  end

  def gainSkill
    case(@class)
    when "Soldat"
      case(@level)
      when 1
        @skills << $SkillList[5]
        @skills << $SkillList[6]
      when 3
        @skills << $SkillList[7+rand(2)]
      when 6
        @skills << $SkillList[9+rand(2)]
      when 9
        @skills << $SkillList[11+rand(2)]
      when 12
        @skills << $SkillList[13+rand(2)]
      when 15
        @skills << $SkillList[15+rand(2)]
      when 18
        @skills << $SkillList[17+rand(2)]
      end
    when "Ingénieur"
      case(@level)
      when 1
        @skills << $SkillList[33]
        @skills << $SkillList[34]
      when 3
        @skills << $SkillList[35+rand(2)]
      when 6
        @skills << $SkillList[37+rand(2)]
      when 9
        @skills << $SkillList[39+rand(2)]
      when 12
        @skills << $SkillList[41+rand(2)]
      when 15
        @skills << $SkillList[43+rand(2)]
      when 18
        @skills << $SkillList[45+rand(2)]
      end
    when "Scientifique"
      case(@level)
      when 1
        @skills << $SkillList[19]
        @skills << $SkillList[20]
      when 3
        @skills << $SkillList[21+rand(2)]
      when 6
        @skills << $SkillList[23+rand(2)]
      when 9
        @skills << $SkillList[25+rand(2)]
      when 12
        @skills << $SkillList[27+rand(2)]
      when 15
        @skills << $SkillList[29+rand(2)]
      when 18
        @skills << $SkillList[31+rand(2)]
      end
    end
  end

  def useItem(name)
    case(name)
    when "Armure régenérante"
      @maxHealth+=10
      @speed+=5
      @maxPower+=8
      @phy_def+=3
      @eng_def+=3
    when "Armure vivante"
      @maxHealth+=15
      @phy_def+=15
      @eng_def-=5
      @speed+=2
      @powRegen-=2
    when "BFK"
      @damage+=16
      @phy_def-=2
      @eng_def-=2
    when "Bouclier énergétique"
      @eng_def+=16
      @phy_def+=6
      @speed-=1
      @maxShield+=5
    when "Chalumeau"
      @damage+=6
      @maxPower+=10
    when "Cheveu divin"
      @maxPower+=15
      @powRegen+=3
      @damage+=5
      @speed+=2
      @maxShield+=5
    when "Combinaison spatiale"
      @maxHealth+=30
      @speed-=5
      @maxPower+=15
    when "Couteau mortel"
      @damage+=15
      @speed+=5
      @powRegen+=3
      if @maxPower-10 < @power
        @maxPower-=10
        @power=@maxPower
      else
        @maxPower-=10
      end
      if @maxHealth-10 < @health
        @maxHealth-=10
        @health=@maxHealth
      else
        @maxHealth-=10
      end
      if @maxShield-5 < @shield
        @maxShield-=5
        @shield=@maxShield
      else
        @maxShield-=5
      end
    when "Cyber-cerveau"
      @maxPower+=15
      @powRegen+=5
      @eng_def+=5
    when "Epée plasmique"
      @damage+=20
      if @maxPower-10 < @power
        @maxPower-=10
        @power=@maxPower
      else
        @maxPower-=10
      end
      @powRegen-=2
    when "Gilet pare-balle"
      @phy_def+=15
      @eng_def+=8
      @speed-=4
    when "Katana"
      @damage+=12
      @powRegen+=4
      @maxShield+=10
      @speed-=2
    when "Lampe blue" #Lampe bleue
      @maxHealth+=25
      @powRegen+=5
      @damage+=3
    when "Magnum 50mm"
      @damage+=7
      @powRegen+=2
      @speed+=3
    when "Pistolet laser"
      @damage+=4
      @powRegen+=3
      @maxPower+=5
    when "Pistolet sonique"
      @damage+=4
      @speed+=4
    when "Tablier de cuisine"
      @phy_def+=2
      @eng_def-=2
      @maxPower+=20
      @powRegen+=2
    when "Tournevis sonique"
      @maxPower+=8
      @powRegen+=3
      @eng_def+=6
      @phy_def-=5
    when "Uniforme de pilote"
      @maxHealth+=15
      @phy_def+=5
      @eng_def-=1
      @speed+=3
    when "Yeux de perception"
      @maxPower+=12
      @speed+=5
      @damage+=2
      @phy_def-=3
      @eng_def-=3
    end

  end

end
