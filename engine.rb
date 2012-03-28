require "./creature.rb"
require "./item.rb"
require "./scene.rb"
require "./wallet.rb"

class Engine
  attr_reader :hero, :rat, :skeleton, :thief, :dragon
  def initialize
    @hero = Creature.new(:name => "Hero", :life => 100, :attack => 20, :defense => 20, :regen => 20, :armor => 0, :weapon => 0)
    @monsters = {
    rat: {name: "Rat", life: 10, attack: 2, defense: 1, regen: 0, armor: 0, weapon: 0},
    skeleton: {name: "Skeleton", life: 30, attack: 6, defense: 4, regen: 0, armor: 0, weapon: 0},
    thief: {name: "Thief", life: 100, attack: 30, defense: 5, regen: 0, armor: 0, weapon: 0},
    dragon: {name: "Dragon", life: 1000, attack: 200, defense: 100, regen: 0, armor: 0, weapon: 0}}
    @armors = [{:name => "Leather armor", :value => 5},
               {:name => "Chain mail", :value => 10},
               {:name => "Plate mail", :value => 15},
               {:name => "Elven chain mail", :value => 100},]
    @weapons = [{:name => "Short sword", :value => 5},
               {:name => "Long sword", :value => 10},
               {:name => "Two-Handed sword", :value => 15},
               {:name => "Warhammer", :value => 100},]
    @city = Scene.new("City", "The city of Casablanca..", [@monsters[:rat], @monsters[:thief]], @armors[0,2],  @weapons[0,2], self)
    @plains = Scene.new("Plains", "The plains are dangerous places..", [@monsters[:thief], @monsters[:skeleton]], @armors[1,2], @weapons[1,2], self)
    @mountains = Scene.new("Mountains", "These mountains hide the curse of this beautiful city..", [@monsters[:skeleton], @monsters[:dragon]], @armors[2,2], @weapons[2,2], self)
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

      damage = attacker.attack + attacker.weapon - defender.defense
      if damage > 0
        defender.life -= damage
        puts "#{attacker.name} hits #{defender.name} for #{damage} points of life."
      else
        puts "#{attacker.name} couldn't damage #{defender.name}."
      end
      if defender.life < 0 && defender.name == "Hero"
        puts "You died, idiot!"
        exit
      elsif defender.life < 0 && defender.name != "Hero"
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
