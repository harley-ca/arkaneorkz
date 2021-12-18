class Character

    attr_accessor :hp, :exploration, :money, :level, :max,:name, :str, :dex, :int, :wrd, :armor, :ward, :damage, :atk

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
            print "#{atkr.name} advances on #{dfndr} lashing out #{desc.sample}, dealing "
            puts "#{dam} damage!".colorize(:red)
            hurt(dfndr, dam)
        elsif
            directions = ["back, putting distance between them", "to the side, looking for an opening", "forward with a feint"]
            print "#{atkr} rushes and swings #{desc.sample}, but #{dfndr.name} "
            print "dodges".colorize(:green)
            puts " #{directions.sample}"
        end
    end

    def improvements
        possible_improvements = [
            {name: "Bigger Musklez (+1 Str)", value: 1},
            {name: "Da Zoomies (+1 Quick)", value: 2},
            {name: "Giga Brain (+1 Smart)", value: 3},
            {name: "Yummy Funny Fungi (+1 Wack)", value: 4},
            {name: "Really, really, really, BIG club (2d6 Str)", value: 5},
            {name: "ORK WITH A NINJA SWORD!? (3d4 Dex)", value: 6},
            {name: "Second Heart (+6 HP)", value: 7},
            {name: "What some might describe as 'Armor' (Armor 13)", value: 8},
            {name: "[The True Blessing of Gruumsh] (???)", value: 9},
            {name: "Déjà vu (???)", value: 10},
        ]
        list = []
        3.times { list.push(possible_improvements.sample) }
        improvement = $prompt.select("Which blezzing you want?".colorize(:green), list)
        return improvement
    end

    def improve
        system("clear")
        level1 = $player.level + 1
        $player.level = level1
        puts "You feel the terrifying maw of Gruumsh smiling down upon you from the heavens..".colorize(:red)
        breakline
        choice = improvements
        case choice
        when 1
            $player.str
        when 2
            $player.dex += 1
        when 3
            $player.int += 1
        when 4
            $player.wrd += 1
        when 5
            $player.damage = "rand(1..6) + rand(1..6)"
        when 6
            $player.damage = "rand(1..4) + (rand1..4) + (rand1..4)"
        when 7
            $player.max + 6
        when 8
            $player.armor = 13
        when 9
            $player.str += 1
            $player.dex += 1
            $player.int += 1
            $player.wrd += 1
            $player.armor += 1
            $player.ward += 1
        when 10
            $player.exploration += 4
        end
        system("clear")
        $player.max += rand(1..6)
        puts "Your max HP is now #{$player.max}"
        breakline
        puts "Prezz Enter to Continue"
        gets
        system("clear")
    end

    def hurt(victim, damage)
        victim.hp -= damage
    end
end