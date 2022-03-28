
# file = File.open("#{title}.txt", 'w')
# file.close
require 'date'
require 'uuidtools'
require 'fileutils'

class InvalidOptionError < StandardError
    def message
        return "Invalid selection, try again"
    end
end

class InvalidFeeling < StandardError
    def message
        return "Invalid entry, feeling must be one of the following: #{entry_categories.feelings.join(', ')}"
    end
end

class Menu

    def initialize(*menu_args)
        @menu_args = menu_args
    end

    #Prints menu with index
    def display_menu
        puts "Please select an option (1 to #{@menu_args.length})"
        puts "Enter \"help\" to see options again"
        @menu_args.each_with_index do |item, index|
            puts "#{index + 1}. #{item}"
        end
    end

    def input_check
        input = ARGV[0]
        unless input.to_i.between?(0, @menu_args.length) == true || input == "help"
            raise InvalidOptionError
        end
    end
end

class Emotions
    attr_reader :feelings

    def initialize(*feelings)
        @feelings = feelings
    end
end

main_menu = Menu.new("New Journal Entry", "View All Journal Entries", "Search Journal Entries", "Exit")

entry_categories = Emotions.new("okay, happy, sad, angry, stressed, anxious, suprised, confused")

def get_feeling
    puts "What is your overall feeling today? #{entry_categories.feelings.join(', ')}"
    input = $stdin.gets.strip.downcase
    unless entry_categories.feelings.include?(input)
        raise(InvalidFeeling)
    end
    return input
end

# Displays error message if menu selection is invalid
begin
    main_menu.input_check
rescue InvalidOptionError => e
    puts e.message
end

case ARGV[0]
when nil, "help"
    main_menu.display_menu
when "1"
    date_time = DateTime.now.strftime("%d/%m/%Y %H:%M")
    id = UUIDTools::UUID.timestamp_create.to_s
    file = File.new("#{id}.txt", 'w')
    FileUtils.move("#{id}.txt", "Entries/#{id}.txt")
    puts "Please enter the title: "
    # Adding title to entry
    file << $stdin.gets.strip + "\n"*2
    # Adding date and time to entry
    file << date_time + "\n"*2
    # puts "What is your overall feeling today? #{entry_categories.feelings.join(', ')}"
    begin
        # feeling = @stdin.gets.strip.downcase
        # unless entry_categories.feelings.include?(feeling)
        #     raise(InvalidFeeling)
        feeling = get_feeling
    rescue InvalidFeeling => e
            puts e.message
            retry
        puts "feelings successful"
        
    end

    
    
when "2"
    puts "view all"
when "3"
    puts "search"
when "4"
    puts "exit"
end


