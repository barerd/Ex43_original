class Creature
  attr_reader :name, :life, :attack, :defense
  attr_writer :life
  def initialize(name, life, attack, defense)
    @name = name
    @life = life
    @attack = attack
    @defense = defense
  end
end

class Monster < Creature
end

class Hero < Creature
  attr_reader :name, :regen
  attr_accessor :life, :attack, :defense, :armor, :weapon
  def initialize(name, life, attack, defense, regen)
    super(name, life, attack, defense)
    @regen = regen
    @armor = 0
    @weapon = 0
  end
end
