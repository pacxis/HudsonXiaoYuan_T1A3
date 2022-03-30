
require 'date'
require 'uuidtools'
require 'fileutils'
require 'json'

# -----------------------CLASSES--------------------

# Class for menus
class Menu

    def initialize(*menu_items)
        @menu_items = menu_items
    end

    # Prints menu with index
    def display_menu
        puts "Please select an option (1 to #{@menu_items.length})"
        puts "Enter 'menu' to see options again"
        @menu_items.each_with_index do |item, index|
            puts "#{index + 1}. #{item}"
        end
    end

    def input_check
        input = ARGV[0]
        unless input.to_i.between?(0, @menu_items.length) == true || input == "menu"
            raise InvalidOptionError
        end
    end
end

# Class for emotions
class Emotions
    attr_reader :feelings

    def initialize(*feelings)
        @feelings = feelings
    end
end

#------------------------OBJECTS-------------------------

main_menu = Menu.new("New Journal Entry", "View All Journal Entries", "Search Journal Entries", "Exit")

entry_categories = Emotions.new("okay", "happy", "sad", "angry", "stressed", "anxious", "suprised", "confused")

# ----------------ERROR CLASSES---------------------------

class InvalidOptionError < StandardError
    def message
        return "Invalid menu selection, try again"
    end
end

class InvalidFeeling < StandardError
    def message(feel)
        return "Invalid feeling entry, input one of the following: #{feel.feelings.join(', ')}"
    end
end

class InvalidIntensity < StandardError
    def message
        return "Invalid intensity entry, input a number from 1 to 5"
    end
end

class InvalidYesNo < StandardError
    def message
        return "Invalid entry, enter 'y' for yes and 'n' for no"
    end
end

# ----------------------METHODS----------------------------

def get_feeling(feel)
    input = gets.strip.downcase
    if feel.feelings.include?(input)
        return input
    else
        raise(InvalidFeeling)
    end
end

def get_intensity
    input = gets.strip.to_i
    if input.between?(1, 5)
        return input
    else
        raise(InvalidIntensity)
    end
end


#-------------------------MAIN CODE-------------------------

# Displays error message if menu selection is invalid
begin
    main_menu.input_check
rescue InvalidOptionError => e
    puts e.message
end

j_index = JSON.load_file('journal_index.json', symbolize_names: true)

case ARGV[0]
when nil, "menu"
    main_menu.display_menu
when "1"
    ARGV.clear
    # Generating current date and time
    date_time = DateTime.now.strftime("%d/%m/%Y %H:%M")
    # Generating unique ID for entry
    id = UUIDTools::UUID.timestamp_create.to_s
    puts "Please enter the title: "
    title = gets.strip
    puts "What is your overall feeling today? (#{entry_categories.feelings.join(', ')})"
    begin
        feeling = get_feeling(entry_categories)
    rescue InvalidFeeling => e
        puts e.message(entry_categories)
        retry
    end
    unless feeling == "okay"
        puts "How would you rank the intensity of this feeling from 1 to 5? (1 being the weakest)"
        begin
            intensity = get_intensity
        rescue InvalidIntensity => e
            puts e.message
            retry
        end
    else
        intensity = 0
    end
    puts "Type out your journal entry: "
    entry = gets.strip
    puts "Do you want to save this entry? (y/n)"

    begin
        selection = gets.strip
        case selection
        when "y"
            puts "Journal entry saved"

            # Writing saved information to txt file
            file = File.open("#{id}.txt", 'w')
            FileUtils.mv("#{id}.txt", "Entries/#{id}.txt")
            file << title + "\n"*2
            file << date_time + + "\n"*2
            file << feeling + " (#{intensity})" + "\n"*2
            file << entry

            # Writing entry info to json file
            entry_info = { title: title, id: id, date: date_time,  feeling: feeling, intensity: intensity }
            File.open('journal_index.json', 'w') do |f|
                f.puts JSON.pretty_generate(j_index << entry_info)
            end
        when "n"
            puts "Journal entry discarded"
        else
            raise InvalidYesNo
        end
    rescue InvalidYesNo => e
        puts e.message
        retry
    end
when "2"
    
when "3"
    puts "search"
when "4"
    puts "exit"
end


