require_relative("./character.rb")
require "tty-prompt"
require "faker"
require "yaml"
require "psych"

$prompt = TTY::Prompt.new
$player = ""


#Shows and returns selection from the main menu
def main_menu
    main_selection = $prompt.select("Pick an option:") do |menu|
        menu.default "Load Game"
        menu.choice "New Game"
        menu.choice "Save Game"
        menu.choice "Load Game"
        menu.choice "Battle Simulator"
        menu.choice "Exit"
    end
    return main_selection
end

#Shows and returns selection from the in-game menu
def game_menu
    game_selection = $prompt.select("What would you like to do?") do |menu2|
        menu2.choice "Explore"
        menu2.choice "Battle"
        menu2.choice "Save Game"
        menu2.choice "Load Game"
        menu2.choice "Battle Simulator"
        menu2.choice "Exit"
    end
    case game_selection
    when "Explore"

    when "Battle"

    when "Save Game"
        if $player != nil
            $player.save_game
        else
            puts "No game to save, try another option."
        end
    when "Battle Simulator"

    when "Exit"

    end
end

def yesno
    yesno = $prompt.select("", %w(No Yes))
    return yesno
end


def quick_stats(arr)
    puts "Strength\t: #{arr[0]}"
    puts "Dexterity\t: #{arr[1]}"
    puts "Intelligence\t: #{arr[2]}"
    puts "Weirdness\t: #{arr[3]}"
    puts "Hitpoints\t: #{arr[4]}"
end

def create_character(manual, named)
    #Manually make the character.
    if manual == -1
        system("clear")

        #Use the name in parameter if relevant, otherwise ask for one.
        if named != ""
            name = named
        else
            puts "What is your name?"
            name = gets.chomp
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

        #Let player pick a starting weapon and apply it's stats to their character
        weapon = ""
        while weapon == ""
            weapon = $prompt.select("Pick your startin weapon:") do |menu|
                menu.choice "Sword    | 1d8 | Strength"
                menu.choice "Spear    | 1d8 | Dexterity"
                menu.choice "Axe      | 1d6 | Strength"
                menu.choice "Dagger   | 1d6 | Dexterity"
            end
            case weapon 
            when "Sword    | 1d8 | Strength"
                attack = ["rand(1..8)","str"]
            when "Spear    | 1d8 | Dexterity"
                attack = ["rand(1..8)","dex"]
            when "Axe      | 1d6 | Strength"
                attack = ["rand(1..6)","str"]
            when "Dagger   | 1d6 | Dexterity"
                attack = ["rand(1..6)","dex"]
            end
        end
        $player = Character.new(name, stats[0], stats[1], stats[2], stats[3], stats[4], 11, 11, attack[0], attack[1], 1, 0, 20)
        puts $player.to_s
    elsif manual == 0
        #Quickly autogenerate a character

        #Arrays used for weapon selection
        a = ["rand(1..6","rand(1..8)"]
        b = ["str", "dex"]

        #Use name from parameter if provided, otherwise get a random one.
        if named != ""
            name = named
        else
            name = Faker::Games::ElderScrolls.name
        end
        

        $player = Character.new(
            name,
            rand(1..6),
            rand(1..6),
            rand(1..6),
            rand(1..6),
            rand(1..8)+2,
            11,
            11,
            a.sample,
            b.sample,
            1,
            2,
            rand(1..50)
        )
    else
        #Generate "monster" at the level provided in manual

        #Use name from parameter if provided, otherwise get a random one.
        if named != ""
            name = named
        else
            name = Faker::Games::DnD.monster
        end
        stats = [rand(1..8), rand(5..15), rand(5..20)]
        b = ["str", "dex"]
        level = manual

        #Use the manual parameter to seed the difficulty of the monster
        if manual == 2
            a = "rand(1..8)"
            hp = stats[3]
        elsif manual >= 10
            a = "rand(5..15)"
            hp = stats[3]+10
        elsif manual >= 30
            a = "rand(5..25)"
            hp = stats[3]+25
        else
            puts "ERROR: ???"
        end
        Character.new(name, stats[0], stats[0], stats[0], stats[0], hp, rand(8..13), rand(8..13), a, b.sample, level, 0, 20)
    end
end

#Check for parameters, if file is named, automatically load, otherwise list all and ask
def load_game(load_file)
    if load_file != ""
        File.open("./saves.yml") do |file_iter|
            YAML.load_stream(file_iter) do |line|
                if line.to_s == load_file
                    return line
                end
            end
        end
    else
        File.open("./saves.yml") do |file_iter|
            YAML.load_stream(file_iter) do |line|
                puts line.file_show
            end
        end
        puts "Which file would you like to load?"
        lf = gets.chomp
        load_game(lf)
    end
end

#Accept arguments from command line
cmd1 = ARGV[0]
cmd2 = ARGV[1]
ARGV.clear
if cmd1 != nil
    if cmd1 == "load"
        #Auto load character optio
    elsif cmd1 == "new"
        if cmd2 != nil
            create_character(-1, cmd2)
            game_menu
        else
            create_character(-1, "")
            game_menu
        end
    elsif cmd1 == "quick"
        if cmd2 != nil
            create_character(0, cmd2)
            game_menu
        else
            create_character(0, "")
            game_menu
        end
    else
        puts "Woops"
    end
end



#Running the application
system "clear"
puts "Welcome to the game! Go forth to adventure!"
main_option = ""
while main_option != "Exit"
    #Call the main menu and get a selection
    main_option = main_menu
    case main_option
    when "New Game"
        create_character(-1, "")
        game_menu
    when "Save Game"
        if $player != nil
            $player.save_game
        else
            puts "No game to save, try another option."
        end
    when "Load Game"
        load_game("")
        game_menu
    when "Battle Simulator"
        puts $player
    else
        puts "Thanks for playing!"
        next
    end
end