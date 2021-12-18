require_relative("./character.rb")
require "tty-prompt"
require "faker"
require "yaml"
require "colorize"
require "terminal-table"

$prompt = TTY::Prompt.new
$player = ""


#Shows and returns selection from the main menu
def main_menu
    main_selection = $prompt.select("Waz iz youz doinz, choom?".colorize(:green)) do |menu|
        menu.choice "Battlin' Orkz!"
        menu.choice "New Ork"
        menu.choice "Save Ork"
        menu.choice "Load Ork"
        menu.choice "Exit"
    end
    return main_selection
end

def yesno
    yesno = $prompt.select("", %w(No Yes))
    return yesno
end

def breakline
    puts ("")
end

def list_saves
    rows = []
    rows.push(["Saved Orkz Here", "Levelz", "EX PEE"])
    rows.push(:separator)
    File.open("./saves.yml") do |file_iter|
        YAML.load_stream(file_iter) do |line|
            rows.push(line.file_show)
        end
    end
    table = Terminal::Table.new :rows => rows
    puts table
end

def battle
    system("clear")
    puts "YOU WISH TO ENTAH DA RING?"
    breakline
    dfndr = ""
    list_saves      
    def_loaded = false
    load_file = gets.chomp
    if load_file == $player
        system("clear")
        puts "HUH?"
        main_menu
    elsif load_file != ""
        File.open("./saves.yml") do |file_iter|
            YAML.load_stream(file_iter) do |line|
                if line.to_s == load_file
                    dfndr = line
                    def_loaded = true
                end
            end
        end
    end
    if def_loaded == true
        $player.hp = $player.max
        dfndr.hp = dfndr.max
        system("clear")
        puts "#{$player.name} enterz da ring."
        breakline
        sleep(0.5)
        puts "#{dfndr.name} rises to the challenge."
        breakline
        sleep(0.5)
        3.times {
            print "."
            sleep(0.4)
        }
        breakline
        print "BWONNNGGGG!".colorize(:brown)
        puts "   FIGHT!".colorize(:red)
        breakline
        sleep(0.5)
        
        if rand(1..6) + 2 >= 4
            $player.attack($player,dfndr)
        else
        end
        while $player.hp > 0 && dfndr.hp > 0
            breakline
            sleep(1)
            dfndr.attack(dfndr, $player)
            breakline
            sleep(1)
            $player.attack($player, dfndr)
            if $player.hp < $player.max / 2
                breakline
                puts "#{$player.name} is looking rough but is ready to keep fighting."
            elsif dfndr.hp < dfndr.max / 2
                breakline
                puts "#{dfndr.name} spits blood onto the ground and grins at #{$player.name} menacingly."
            end
        end
        breakline
        if $player.hp > 0 
            winnings = rand(1..15)
            $player.exploration += 1
            $player.money += winnings
            puts "YARR!!!!!!! Great work #{$player}, you'll be Big Cheef in no time!".colorize(:green)
            sleep(5)
            system("clear")
            puts "#{$player} WINZ! $#{winnings} PAIDZ OUT!".colorize(:green)
        elsif $player.hp == 0 || $player.hp < 0
            puts "HAR HAR HAR HAR! You gotz zmacked, #{$player}!".colorize(:red)
            sleep(5)
            system("clear")
            puts "YOU LOOZ! Come backz when you fink you can takez #{dfndr.name}".colorize(:red)
        end
        if $player.exploration.remainder(5) == 0
            $player.improve
        else 
        end
    elsif def_loaded != true
        system("clear")
        puts ("Datz no Ork I ever herdz of.")
        main_menu
    end
end


def quick_stats(arr)
    puts "Strongth\t| #{arr[0]}"
    puts "Quickz\t\t| #{arr[1]}"
    puts "Smartz\t\t| #{arr[2]}"
    puts "Wackness\t| #{arr[3]}"
    puts "Hurtpoints\t| #{arr[4]}"
end

def create_character(manual, named)
    if manual == -1
    #Manually make the character.
        name = nil
        system("clear")
        until name != "" && name != nil && name.length < 20
            #Use the name in parameter if relevant, otherwise ask for one.
            if named != ""
                name = named
            else
                puts "Whatz is youz name? Not too longz, me no write good."
                name = gets.chomp
            end
        end
        #Roll stats until player accepts them
        confirm_stat = ""
        while confirm_stat != "Yes"
            system("clear")
            puts "#{name}'s Stats:"
            stats = [rand(1..6), rand(1..6), rand(1..6), rand(1..6), rand(1..8)+2]
            quick_stats(stats)
            confirm_stat = $prompt.select("Are you happy with these stats?", %w(No Yes))
        end
        system("clear")
        #Let player pick a starting weapon and apply it's stats to their character
        weapon = ""
        while weapon == ""
            weapon = $prompt.select("Pick your startin weapon:") do |menu|
                menu.choice "Zword    | 1d8   | Strength"
                menu.choice "Zpear    | 1d8   | Dexterity"
                menu.choice "Ax'em    | 1d6+1 | Strength"
                menu.choice "Stabber  | 1d6+1 | Dexterity"
            end
            case weapon 
            when "Zword    | 1d8   | Strength"
                attack = ["rand(1..8)","str"]
            when "Zpear    | 1d8   | Dexterity"
                attack = ["rand(1..8)","dex"]
            when "Ax'em    | 1d6+1 | Strength"
                attack = ["rand(1..6)+1","str"]
            when "Stabber  | 1d6+1 | Dexterity"
                attack = ["rand(1..6)+1","dex"]
            end
        end
        $player = Character.new(name, stats[0], stats[1], stats[2], stats[3], stats[4], 11, 11, attack[0], attack[1], 1, 0, 20, stats[4])
        puts $player.to_s
    elsif manual == 0
    #Quickly autogenerate a character

        #Arrays used for weapon selection
        a = ["rand(1..6)+1","rand(1..8)"]
        b = ["str", "dex"]

        #Use name from parameter if provided, otherwise get a random one.
        if named != ""
            name = named
        else
            name = Faker::Games::ElderScrolls.name
        end

        hp = rand(1..8) + 2

        $player = Character.new(
            name,
            rand(1..6),
            rand(1..6),
            rand(1..6),
            rand(1..6),
            hp,
            11,
            11,
            a.sample,
            b.sample,
            1,
            2,
            0,
            hp,
            
        )
    else
    end
end

#Check for parameters, if file is named, automatically load, otherwise list all and ask
def load_game(load_file)
    if load_file != ""
        File.open("./saves.yml") do |file_iter|
            YAML.load_stream(file_iter) do |line|
                if line.to_s == load_file
                    $player = line
                    system("clear")
                    puts ("#{$player} waz loaded.")
                end
            end
        end
    else
        list_saves
        puts "Oi! Which Orkz iz you?"
        lf = gets.chomp
        if lf.length > 0 
            load_game(lf)
        else
            system("clear")
            puts "Dun wayztin my time denz!"
            main_menu
        end
    end
end

#Accept arguments from command line
cmd1 = ARGV[0]
cmd2 = ARGV[1]
ARGV.clear
if cmd1 != nil
    if cmd1 == "load"
        if cmd2 != nil
            load_game(cmd2)
        else
            load_game("")
        end
    elsif cmd1 == "new"
        if cmd2 != nil
            create_character(-1, cmd2)
        else
            create_character(-1, "")
        end
    elsif cmd1 == "quick"
        if cmd2 != nil
            create_character(0, cmd2)
        else
            create_character(0, "")
        end
    else
        puts "Woopzie!"
    end
end



#Running the application
main_option = ""
system "clear"
puts "Welcome to Battle Orkz!"
while main_option != "Exit"
    #Call the main menu and get a selection
    main_option = main_menu
    case main_option
    when "Battlin' Orkz!"
        if $player != nil && $player != ""
            battle()
        else
            system("clear")
            puts "You can't battle Orkz unless you'ze an Ork youzelf. Kapizh?"
        end
    when "New Ork"
        create_character(-1, "")
        system "clear"
        puts "#{$player.to_s} created."
    when "Save Ork"
        if $player != nil && $player != ""
            $player.save_game
            system("clear")
            puts "#{$player.to_s} waz zaved."
        else
            system("clear")
            puts "What Ork? You ain't no Ork. Try again, Pal."
        end
    when "Load Ork"
        load_game("")
    else
        puts "Thanks for playing!"
        next
    end
end