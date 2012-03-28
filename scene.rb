require "./creature.rb"

class Scene
  attr_reader :name, :monsters, :armors, :weapons
  def initialize(name, intro, monsters, armors, weapons, engine)
    @name = name
    @intro = intro
    @monsters = monsters
    @armors = armors
    @weapons = weapons
    @engine = engine
  end

  def intro
    puts "You are in the " + @name + "." + @intro
    list_equipment
    action
  end

  def list_equipment
    puts "You see some equipment around:"
    @armors.each {|a| puts a[:name]}
    @weapons.each {|w| puts w[:name]}
  end

  def action
    puts <<-ACTION
    
What do you want to do?
1. Take armor
2. Take weapon
3. Battle monsters
4. Go to somewhere else

    ACTION
    choice = gets.chomp
    if choice == "1"
      take_armor
    elsif choice == "2"
      take_weapon
    elsif choice == "3"
      monster = Creature.new(@monsters[rand(2)])
      @engine.battle(monster)
    elsif choice == "4"
      @engine.gone
    else
      puts "What?!"
      @engine.play(@name.downcase.to_sym)
    end
  end

  def take_armor
    puts "Which one do you take?"
    @armors.each_with_index {|a,i| puts "#{i+1}. #{a[:name]}"}
    choice = (gets.chomp.to_i) -1
    @engine.hero.armor = 0
    @engine.hero.armor += @armors[choice][:value]
    puts "Now you have #{@engine.hero.armor} armor.\n "
  end

  def take_weapon
    puts "Which one do you take?"
    @weapons.each_with_index {|w,i| puts "#{i+1}. #{w[:name]}"}
    choice = (gets.chomp.to_i) -1
    @engine.hero.weapon = 0
    @engine.hero.weapon += @weapons[choice][:value]
    puts "Now you have #{@engine.hero.weapon} weapon.\n "
  end
end
