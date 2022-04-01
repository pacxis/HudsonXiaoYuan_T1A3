
require 'date'
require 'uuidtools'
require 'fileutils'
require 'json'
require 'tty-prompt'

# -----------------------CLASSES--------------------

# Class for menus
class Menu
    attr_reader :menu_items
    def initialize(*menu_items)
        @menu_items = menu_items
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

view_entries_menu = Menu.new("By date", "By feeling", "By title alphabetical order")

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


# begin
#     main_menu.input_check
# rescue InvalidOptionError => e
#     puts e.message
# end

j_index = JSON.load_file('journal_index.json', symbolize_names: true)
prompt = TTY::Prompt.new

selection = nil

while selection != "Exit" do
    selection = prompt.select("What would you like to do?", main_menu.menu_items)
    case selection
    when main_menu.menu_items[0]

        date = Date.today.strftime("%d/%m/%Y")
        id = UUIDTools::UUID.timestamp_create.to_s
        title = prompt.ask("Please enter the title: ")
        feeling = prompt.select("What is your overall feeling today?", entry_categories.feelings)
        unless feeling == "okay"
            intensity = prompt.ask("How would you rank the intensity of this feeling from 1 to 5? (1 being the weakest)") do |num|
                num.in "1-5"
                num.messages[:range?] = "Invalid input, select a number from 1 to 5"
            end
            # begin
            #     intensity = get_intensity
            # rescue InvalidIntensity => e
            #     puts e.message
            #     retry
            # end
        else
            intensity = 0
        end
        entry = prompt.ask("Type out your journal entry: ")
        
        selection = prompt.yes?("Do you want to save this entry?")
    
        if selection == true
            file = File.open("#{id}.txt", 'w')
            FileUtils.mv("#{id}.txt", "Entries/#{id}.txt")
            file << title + "\n"*2
            file << date + "\n"*2
            file << feeling + " (#{intensity})" + "\n"*2
            file << entry


            entry_info = { title: title, id: id, date: date, feeling: feeling, intensity: intensity }
            File.open('journal_index.json', 'w') do |f|
                f.puts JSON.pretty_generate(j_index << entry_info)
            end
             puts "Journal entry saved"
        else 
            puts "Journal entry discarded"
        end
    when main_menu.menu_items[1]
        prompt.ask()
    when main_menu.menu_items[2]
        puts "hello"
    end
end





