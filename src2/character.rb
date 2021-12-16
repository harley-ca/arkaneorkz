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

    def save_game
        #Convert attributes to hash and save to file
        save = [
            @name.to_s, @str, @dex, @int, @wrd, @hp, @armor, @ward, @damage, @atk, @level, @exploration, @money
        ]

        saved = ""
        save_staging = File.read("saves.txt")
        saves = save_staging.split("\n")
        puts saves
        puts "Top Save:"
        puts saves[0]
        puts "Saving:"
        puts save.to_s
        gets
        i = 0
        while saved != true && i < saves.length
            line = saves[i].split(",")
            
            if line[0].gsub("\"", "") == "[#{save[0]}"
                puts "THIS IS IMPORTANT"
                puts line
                line_split = line.map{ |string| string.gsub("\"", "").gsub("[", "").gsub("]", "") }
                puts line_split.to_s
                puts save.to_s
                gets
                save_file_split = save_staging.split(line_split).insert(1, save.to_s)
                save_file_split.each do |i|
                    File.write("saves.txt", save_file_split[i], mode: "a")
                end
                saved = true
                puts "Save Successful! Press Enter to continue.."
                gets
            end
            i += 1
        end
        if saved != true
            File.write("saves.txt", "\n", mode: "a")
            File.write("saves.txt", save.to_s, mode: "a")
            saved = true
            puts "New Save Successful! Press Enter to continue.."
            gets
        end
    end
end

