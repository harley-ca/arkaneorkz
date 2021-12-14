class weapon
    def initialize(weapon_name, enchant, description, stats, attack_desc)
        @weapon_name = weapon_name
        @stats = stats #atk bonus, damage, hands, stat, lootable
        @enchant = enchant
        @description = description
        @attack_desc = attack_desc
    end

    def damage()
        #damage + enchant damage
        dmg = 0
        if enchant #add enchant if relevent
            #enchant effect
        end

        if #stats[damage] = 1d6
            return rand(1..6)
        elsif #stats = 1d8
            return rand(1..8)
        elsif # 1d10
            return rand(1..10)
        end
    end

end