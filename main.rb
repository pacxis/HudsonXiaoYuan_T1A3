
require 'date'
require 'uuidtools'
require 'fileutils'
require 'json'
require 'tty-prompt'

require_relative 'classes.rb'

#------------------------OBJECTS-------------------------

main_menu = Menu.new("New Journal Entry", "View All Journal Entries", "Search Journal Entries", "Exit")

entry_categories = Emotions.new("okay", "happy", "sad", "angry", "stressed", "anxious", "suprised", "confused")

view_menu = Menu.new("By date", "By feeling", "By title alphabetical order")

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

#-------------------------MAIN CODE-------------------------


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
        selection = prompt.select("How would you like to view your entries?", view_menu.menu_items)
        # j_index.each do |etr|
        sorted_entries = j_index.sort_by { |key| key[:intensity]}
        puts sorted_entries
        case selection
        when view_menu.menu_items[0]
            puts 'ere'
        when view_menu.menu_items[1]
            puts 'ether'
        when view_menu.menu_items[2]
            puts 'etets'
        end
    when main_menu.menu_items[2]
        date = rand(1..30).to_s + '/' + rand(1..12).to_s + '/' + rand(2020..2021).to_s
        title = "bad mood"
        feeling = "angry"
        intensity = rand(1..5)
    # intensity = 0
        id = UUIDTools::UUID.timestamp_create.to_s
        entry = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus augue sit amet tincidunt ornare. Donec nec venenatis nisl, rutrum scelerisque nibh. Sed a tincidunt felis. Praesent rutrum semper fringilla. Donec hendrerit nulla sed ultrices efficitur. Nullam sit amet molestie nibh. Quisque eget ornare lectus. Proin in accumsan lectus. Pellentesque lectus orci, accumsan id diam et, volutpat aliquam lorem. Integer consequat faucibus ullamcorper. Nulla interdum accumsan quam, sit amet condimentum erat blandit ut."
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
        file.close
    end
end





