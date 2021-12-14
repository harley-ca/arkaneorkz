class Character
    def initialize(name, stats, hp, armor, ward)
        @name = name
        @stats = stats
        @hp = hp
        @armor = armor
        @ward = ward
    end

    def to_s
        @name
    end
end