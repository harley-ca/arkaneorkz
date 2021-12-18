class Character

    attr_reader :name, :str, :dex, :int, :wrd, :armor, :ward, :damage, :atk, :max
    attr_accessor :hp, :exploration, :money, :level

    def initialize(name, str, dex, int, wrd, hp, armor, ward, damage, atk, level, exploration, money, max)
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
        @max = max
    end

    def to_s
        return @name
    end

    def xp
        return @exploration
    end

    def file_show
        return ["#{@name}", "#{@level}", "#{@exploration}"]
    end

    def stats
        puts "Strongth\t|\t#{@str}"
        puts "Quickz\t|\t#{@dex}"
        puts "Smartz\t|\t#{@int}"
        puts "Wackness\t|\t#{@wrd}"
        puts "Hurtpoints\t|\t#{@hp}"
        puts "Armoredness\t|\t#{@armor}"
        puts "Magikked\t|\t#{@ward}"
        puts "Ork Level\t|\t#{@level}"
    end

    def save_game
        file_found = ""
        overwrite = ""
        save = $player.to_yaml
        File.open("./saves.yml") do |file_iter|
            YAML.load_stream(file_iter) do |line|
                if line.to_s == $player.to_s
                    file_found = true
                    $slot = line
                    puts "Do you want to save over #{line.file_show}"
                    overwrite = yesno
                    system("clear")
                end
            end
        end
        if file_found == true && overwrite == "Yes"
            temp_file = File.read("./saves.yml").gsub($slot.to_yaml, save)
            File.write("./saves.yml", temp_file, mode: "w")
            puts "#{@name} waz zaved to da phial."
        elsif file_found == true && overwrite == "No"
            print "Please choose a new name: "
            named = gets.chomp
            @name = named
            save_game
        else file_found == false
            File.write("./saves.yml", save, mode: "a")
            puts "#{@name} waz zaved to da phial."
        end
    end

    def attack(atkr,dfndr)
        if atkr.atk == "dex"
            attack_stat = atkr.dex
            desc = ["deftly", "smoothly", "with great finesse and speed", "in a flash"]
        elsif atkr.atk == "str"
            attack_stat = atkr.str
            desc = ["wildly", "dangerously", "with much effort and obscene grunting", "with brutal strength"]
        end
        if rand(1..20) + attack_stat >= dfndr.armor
            dam = eval(atkr.damage)
            puts "#{atkr.name} advances on #{dfndr} lashing out #{desc.sample}, dealing #{dam} damage!"
            hurt(dfndr, dam)
        elsif
            directions = ["back, putting distance between them", "to the side, looking for an opening", "forward with a feint"]
            puts "#{atkr} rushes and swings #{desc.sample}, but #{dfndr.name} dodges #{directions.sample}"
        end
    end

    def improvements
        possible_improvements = [
            {}
            "+1 Quickz",
            "+1 Smartz",
            "+1 Wackness",
            "Really Big Axe",
            ""
        ]
        improvement = $prompt.select("Which blezzing you want?".colorize(:green)) do |menu|
            menu.choice "Battlin' Orkz!"
            menu.choice "New Ork"
            menu.choice "Save Ork"
            menu.choice "Load Ork"
            menu.choice "Exit"
        end
        return main_selection
    end

    def improve
        system("clear")
        level1 = $player.level + 1
        $player.level = level1
        puts "You feel the terrifying maw of Gruumsh smiling down upon you from the heavens.."



        $player.hp += rand(1..6)
    end

    def hurt(victim, damage)
        victim.hp -= damage
    end
end