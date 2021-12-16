class Character

    attr_reader :name, :str, :dex, :int, :wrd, :armor, :ward, :damage, :atk, :lvl
    attr_accessor :hp

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
        return @name
    end

    def file_show
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
        file_found = ""
        overwrite = ""
        puts "Saving the game.."
        save = $player.to_yaml
        File.open("./saves.yml") do |file_iter|
            YAML.load_stream(file_iter) do |line|
                if line.to_s == $player.to_s
                    file_found = true
                    $slot = line
                    puts "Do you want to save over #{line.file_show}"
                    overwrite = yesno
                end
            end
        end
        if file_found == true && overwrite == "Yes"
            temp_file = File.read("./saves.yml").gsub($slot.to_yaml, save)
            File.write("./saves.yml", temp_file, mode: "w")
        elsif file_found == true && overwrite == "No"
            print "Please choose a new name: "
            named = gets.chomp
            @name = named
            save_game
        else file_found == false
            File.write("./saves.yml", save, mode: "a")
        end
    end

    def attack(atkr,dfndr)
        if atkr.atk == "dex"
            attack_stat = atkr.dex
        elsif atkr.atk == "str"
            attack_stat = atkr.str
        end
        if rand(1..20) + attack_stat >= dfndr.armor
            dfndr.hp -= eval(atkr.damage)
        end
    end
end