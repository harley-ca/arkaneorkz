
require "tty-prompt"

#define global variables
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
        print "New game"
    when "Load Game"
        print "Load game"
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