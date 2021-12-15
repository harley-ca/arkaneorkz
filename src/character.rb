require_relative("./weapon.rb")

class Character
    def initialize(name, stats, hp, armor, ward, weapon)
        @name = name
        @stats = stats
        @hp = hp
        @armor = armor
        @ward = ward
        @weapon = weapon
    end

    def to_s
        @name
    end
end