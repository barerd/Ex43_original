require "./creature.rb"
require "./item.rb"
require "./scene.rb"
require "./wallet.rb"

class Engine
  attr_reader :hero
  def initialize
    @hero = Hero.new("Hero", 100, 20, 10, 5)
    @rat = Creature.new("Rat", 10, 2, 1)
    @skeleton = Creature.new("Skeleton", 30, 6, 4)
    @thief = Creature.new("Thief", 100, 30, 5)
    @dragon = Creature.new("Dragon", 1000, 200, 100)
    @armors = [{:name => "Leather armor", :value => 5},
               {:name => "Chain mail", :value => 10},
               {:name => "Plate mail", :value => 15},
               {:name => "Elven chain mail", :value => 100},]
    @weapons = [{:name => "Short sword", :value => 5},
               {:name => "Long sword", :value => 10},
               {:name => "Two-Handed sword", :value => 15},
               {:name => "Warhammer", :value => 100},]
    @city = Scene.new("City", "The city of Casablanca..", [@rat, @thief], @armors[0,2], @weapons[0,2], self)
    @plains = Scene.new("Plains", "The plains are dangerous places..", [@rat, @thief], @armors[1,2], @weapons[1,2], self)
    @mountains = Scene.new("Mountains", "These mountains hide the curse of this beautiful city..", [@rat, @thief], @armors[2,2], @weapons[2,2], self)
    @wallet = Wallet.new(200)
    @scenes = {:city => @city, :plains => @plains, :mountains => @mountains}
  end

  def play(place)
    while true
      @scenes[place].intro
    end
  end

  def gone
    puts <<-WHERE
Where do you wanna go?
1. City
2. Plains
3. Mountains

    WHERE
    choice = gets.chomp
    if choice == "1"
      play(:city)
    elsif choice == "2"
      play(:plains)
    elsif choice == "3"
      play(:mountains)
    else
      puts "What?! Get the hell outta here!!"
      exit
    end
  end

  def battle(monster)
    opponents = [@hero, monster]
    i = 0
    while true
      attacker = opponents[i % 2]
      defender = opponents[(i+1) % 2]

      damage = attacker.attack
      defender.life -= (damage - defender.defense)
      puts "#{attacker.name} hits #{defender.name} for #{damage} points, but #{defender.name} absorbs #{defender.defense} of it."

      if defender.life < 0
        break
      end
      if defender.name == "Hero"
        defender.life += defender.regen
        puts "#{defender.name} regenerates #{defender.regen} points of life."
      end
      i += 1
    end
    puts "#{attacker.name} wins with #{attacker.life} hit points left!\n "
  end
end

game = Engine.new
game.play(:city)   
