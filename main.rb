
require 'date'
require 'uuidtools'
require 'fileutils'
require 'json'
require 'tty-prompt'
require 'awesome_print'
require 'colorize'

require_relative 'classes'
require_relative 'methods'

main_menu = Menu.new("New Journal Entry", "View All Journal Entries", "Search Journal Entries", "Exit")

entry_categories = Emotions.new("okay", "happy", "sad", "angry", "stressed", "anxious", "suprised", "confused")

view_menu = Menu.new("By date", "By feeling", "By title alphabetical order", "Return to main menu")

view_menu_after = Menu.new("View another entry", "Delete this entry", "Return to previous menu")

search_menu = Menu.new(
    "Begin search",
    "View search parameters",
    "Clear search parameters",
    "Enter year parameter",
    "Enter month parameter",
    "Enter day parameter",
    "Enter title parameter",
    "Enter feeling parameter",
    "Enter intensity parameter",
    "Return to main menu"
)

j_index = JSON.load_file('journal_index.json', symbolize_names: true)
prompt = TTY::Prompt.new
selection = nil

while selection != main_menu.menu_items[-1]
    system "clear"
    selection = ARGV[0].to_s
    selection = prompt.select("What would you like to do?", main_menu.menu_items) if selection == ""

    case selection
    when main_menu.menu_items[0], '-n'

        date = Date.today.strftime("%d/%m/%Y")
        id = UUIDTools::UUID.timestamp_create.to_s
        title = prompt.ask("Please enter the title: ")
        feeling = prompt.select("What is your overall feeling today?", entry_categories.feelings)
        intensity = if feeling == "okay"
                        0
                    else
                        prompt.ask("How would you rank the intensity of this feeling from 1 to 5? (1 being the weakest)") do |num|
                            num.in "1-5"
                            num.messages[:range?] = "Invalid input, select a number from 1 to 5"
                        end
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
            file.close

            entry_info = {
              title: title.downcase,
              id: id,
              date: date,
              feeling: feeling,
              intensity: intensity
            }

            File.open('journal_index.json', 'w') do |f|
                f.puts JSON.pretty_generate(j_index << entry_info)
            end
            puts "Journal entry saved"
        else
            puts "Journal entry discarded"
        end

    when main_menu.menu_items[1], '-v'
        begin
            raise NoEntriesError if j_index.empty?
        rescue NoEntriesError => e
            puts e.message
        end

        while selection != view_menu.menu_items[-1]
            system "clear"
            selection = prompt.select("How would you like to view your journal entries?", view_menu.menu_items)

            case selection
            when view_menu.menu_items[0]
                while selection != view_menu_after.menu_items[-1]
                    sorted_entries = j_index.sort_by { |h| h[:date].split('/').reverse }
                    sorted_entries.each_with_index do |hash, index|
                        puts "\nJournal Entry #{index + 1}".underline
                        ap hash.slice(:date, :title, :feeling, :intensity)
                    end
                    selection = display_entry(sorted_entries, view_menu_after.menu_items)
                end

            when view_menu.menu_items[1]
                while selection != view_menu_after.menu_items[-1]
                    sorted_entries = j_index.sort { |a, b| [a[:feeling], a[:intensity]] <=> [b[:feeling], b[:intensity]] }
                    sorted_entries.each_with_index do |hash, index|
                        puts "\nJournal Entry #{index + 1}".underline
                        ap hash.slice(:feeling, :intensity, :title, :date)
                    end
                    selection = display_entry(sorted_entries, view_menu_after.menu_items)
                end

            when view_menu.menu_items[2]
                while selection != view_menu_after.menu_items[-1]
                    sorted_entries = j_index.sort_by { |h| h[:title] }
                    sorted_entries.each_with_index do |hash, index|
                        puts "\nJournal Entry #{index + 1}".underline
                        ap hash.slice(:title, :feeling, :intensity, :date)
                    end
                    selection = display_entry(sorted_entries, view_menu_after.menu_items)
                end
            end
        end

    when main_menu.menu_items[2], '-s'
        begin
            raise NoEntriesError if j_index.empty?
        rescue NoEntriesError => e
            puts e.message
        end

        s_selection = nil
        parameters = {}
        while s_selection != search_menu.menu_items[-1]
            j_index = JSON.load_file('journal_index.json', symbolize_names: true)
            s_result = []
            selection = nil
            s_selection = prompt.select("What would you like to do?", search_menu.menu_items, per_page: 10)
            case s_selection
            when search_menu.menu_items[0]
                tfi_param = parameters.slice(:title, :feeling, :intensity)
                s_result = if tfi_param.empty?
                               j_index
                           else
                               j_index.select do |hash|
                                   tfi_param.all? do |key, value|
                                       hash[key].to_s.include? value.to_s
                                   end
                               end
                           end
                if parameters.key?(:year)
                    s_result = s_result.select { |hash| hash[:date][6..9].to_i == parameters[:year] }
                end
                if parameters.key?(:month)
                    s_result = s_result.select { |hash| hash[:date][3..4].to_i == parameters[:month] }
                end
                if parameters.key?(:day)
                    s_result = s_result.select { |hash| hash[:date][0..1].to_i == parameters[:day] }
                end
                while selection != view_menu_after.menu_items[-1]
                    s_result.each_with_index do |hash, index|
                        puts "\nJournal Entry #{index + 1}".underline
                        ap hash.slice(:title, :date, :feeling, :intensity)
                    end
                    if s_result.empty?
                        begin
                            raise NoResultsError
                        rescue NoResultsError => e
                            puts e.message
                        end
                        break
                    end
                    selection = display_entry(s_result, view_menu_after.menu_items)
                end
            when search_menu.menu_items[1]
                if parameters.empty?
                    puts
                else
                    ap parameters
                end
            when search_menu.menu_items[2]
                parameters.clear
                puts "Search parameters cleared"
            when search_menu.menu_items[3]
                year = get_date("year", "1-9999")
                parameters[:year] = year
            when search_menu.menu_items[4]
                month.to_i = get_date("month", "1-12")
                parameters[:month] = month
            when search_menu.menu_items[5]
                day.to_i = get_date("day", "1-31")
                parameters[:day] = day
            when search_menu.menu_items[6]
                title = prompt.ask("Enter the title parameter: ")
                parameters[:title] = title.downcase
            when search_menu.menu_items[7]
                feeling = prompt.select("Select the feeling parameter:", entry_categories.feelings, per_page: 10)
                parameters[:feeling] = feeling
                if feeling == "okay"
                    intensity = 0
                    parameters[:intensity] = intensity
                end
            when search_menu.menu_items[8]
                if feeling == "okay"
                    puts "Intensity defaults to 0 if feeling parameter is 'okay'"
                else
                    intensity = prompt.ask("Enter the intensity parameter: ") do |a|
                    a.in "1-5"
                    a.messages[:range?] = "Invalid input, enter a number from 1 to 5"
                    end
                    parameters[:intensity] = intensity.to_i
                end
            end
        end
    when main_menu.menu_items[3]
        exit
    else
        begin
            raise InvalidArgument
        rescue InvalidArgument => e
            puts e.message
        end
        exit
    end
    ARGV.clear
end





