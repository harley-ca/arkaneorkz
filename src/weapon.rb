class Weapon
    attr_reader :description
    def initialize(weapon_name, attack_bonus, damage_calc, damage, hands, enchant, lootable, description, attack_style)
        @weapon_name = weapon_name
        @attack_bonus = attack_bonus
        @damage_calc = damage_calc
        @damage = damage
        @hands = hands
        @enchant = enchant
        @lootable = lootable
        @description = description
        @attack_style = attack_style
    end

    def to_s
        print "#{@weapon_name} | +#{@attack_bonus} | #{@damage} | #{@hands}h"
    end

    def about
        print "#{@weapon_name}, #{@description}, #{@enchant}"
    end

    def damage
        dmg = eval @damage_calc
        return dmg
    end
end

knife = Weapon.new("Knife", 3, "rand(1..6)", "1d6", 1, "", true, "A small sharp knife.", "stabbing")

