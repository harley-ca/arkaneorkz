require_relative("./character.rb")
require "tty-prompt"

$prompt = TTY::Prompt.new

#Accept arguments from command line
if ARGV.length > 0
    if ARGV[0] == "load"
        #Auto load character option
    elsif ARGV[0] == ""
        #Some other option
    else
        #Bad option
    end

    if ARGV[1] == ""
        #Other settings from args
    end
end

def quick_stats(arr)
    puts "Strength\t: #{arr[0]}"
    puts "Dexterity\t: #{arr[1]}"
    puts "Intelligence\t: #{arr[2]}"
    puts "Weirdness\t: #{arr[3]}"
    puts "Hitpoints\t: #{arr[4]}"
end

def create_character(manual)
    if manual == 1
        system("clear")

        #Get Character name
        puts "What is your name?"
        name = gets.chomp

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
        $player = Character.new(name, stats[0], stats[1], stats[2], stats[3], stats[4], 11, 11, attack[0], attack[1], 0, 0, 20)
        puts $player.to_s
    else

    end
end


#Shows and returns selection from the main menu
def main_menu
    main_selection = $prompt.select("Pick an option:") do |menu|
        menu.default "Load Game"
        menu.choice "New Game"
        menu.choice "Load Game"
        menu.choice "Battle Simulator"
        menu.choice "Exit"
    end
    return main_selection
end

#Shows and returns selection from the in-game menu
def game_menu
    game_selection = $prompt.select("What would you like to do?") do |menu2|
        menu.default "Battle"
        menu.choice "Explore"
        menu.choice "Battle"
        menu.choice "Save"
        menu.choice "Load"
        menu.choice "Exit"
    end
    return game_selection
end

#Shows saved games and returns selection to load
def load_game
    load_selection = $prompt.select("Which file would you like to load?") do |menu3|
        #Print all current save files
    end
    return load_selection
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
        create_character(1)
        game_menu
    when "Load Game"
        $player = load_game
        game_menu
    when "Battle Simulator"
        print "Battle sim"
    else
        puts "Thanks for playing!"
        next
    end
    print "Press Enter key to continue..."
    gets 
    system "clear"
end