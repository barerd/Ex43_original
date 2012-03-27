class Item
  def initialize(setup)
    @name = setup[:name]
    @value = setup[:value]
  end
end

class Weapon < Item
end

class Armor < Item
end
