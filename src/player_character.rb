require_relative("./character.rb")

class PlayerCharacter < Character
    def initialize(name, stats, hp, armor, ward, weapon, xp, level)
        super(name, stats, hp, armor, ward, weapon)
        @xp = xp
        @level = level
    end

    def to_s
        return "#{@name} | Lvl: #{@level} | XP: #{@xp}"
    end

    def get_stats
        puts "Strength\t|\t#{xstats[:str]}"
        puts "Dexterity\t|\t#{xstats[:dex]}"
        puts "Intelligence\t|\t#{xstats[:int]}"
        puts "Weirdness\t|\t#{xstats[:wrd]}"
    end

    def create_character
        system("clear")
        puts "Welcome to the character creator!"
        puts "What will your name be?"
        xname = gets.chomp
        print "Rolling stats"
        3.times {
            sleep(0.2)
            print "."
        }
        @stats = {:str => rand(1..6), :dex => rand(1..6), :int => rand(1..6), :wrd => rand(1..6)}

    end
end

harley = 