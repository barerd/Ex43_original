class Creature
  attr_reader :name, :attack, :defense, :regen
  attr_accessor :life, :armor, :weapon
  def initialize(setup)
    @name = setup[:name]
    @life = setup[:life]
    @attack = setup[:attack]
    @defense = setup[:defense]
    @regen = setup[:regen]
    @armor= setup[:armor]
    @weapon = setup[:weapon]
  end
end
