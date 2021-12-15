class Character

    attr_reader :name

    def initialize(name, str, dex, int, wrd, hp, armor, ward, damage, atk, level, exploration, money)
        @name = name
        @str = str
        @dex = dex
        @int = int
        @wrd = wrd
        @hp = hp
        @armor = armor
        @ward = ward
        @damage = damage
        @atk = atk
        @level = level
        @exploration = exploration
        @money = money
    end

    def to_s
        return "#{@name} | Level: #{@level}"
    end

    def stats
        puts "Strength\t|\t#{@str}"
        puts "Dexterity\t|\t#{@dex}"
        puts "Intelligence\t|\t#{@int}"
        puts "Weirdness\t|\t#{@wrd}"
        puts "Hitpoints\t|\t#{@hp}"
        puts "Armor Value\t|\t#{@armor}"
        puts "Ward Value\t|\t#{@ward}"
        puts "Character Level\t|\t#{@level}"
    end



end

