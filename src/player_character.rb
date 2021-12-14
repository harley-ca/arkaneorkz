require_relative("./character.rb")

class PlayerCharacter <Character
    def initialize(name, weapon, xp, level)
        super(name)
        @weapon = weapon
        @xp = xp
        @level = level
    end

    def to_s
        return "#{@name} | Lvl: #{@level} | XP: #{@xp}"
    end
end