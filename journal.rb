
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

class Menu
    attr_reader :menu_args
    
    def initialize(*menu_args)
        @menu_args = menu_args
    end

    #Prints menu
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



main_menu = Menu.new("New Journal Entry", "View All Journal Entries", "Search Journal Entries", "Exit")

# puts "enter \"help\" to see options"

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
    date_time = DateTime.now

    id = UUIDTools::UUID.timestamp_create.to_s
    file = File.new("#{id}.txt", 'w')
    FileUtils.move("#{id}.txt", "Entries/#{id}.txt")
    puts "Please enter the title: "
    file << $stdin.gets.strip + "\n"*2
    file << date_time.strftime("%d/%m/%Y %H:%M") + "\n"*2
when "2"
    puts "view all"
when "3"
    puts "search"
when "4"
    puts "exit"
end


