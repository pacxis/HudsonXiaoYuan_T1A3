class Menu
    attr_reader :menu_items
    def initialize(*menu_items)
        @menu_items = menu_items
    end

    def display_menu
        puts "Please select an option (1 to #{@menu_items.length})"
        puts "Enter 'menu' to see options again"
        @menu_items.each_with_index do |item, index|
            puts "#{index + 1}. #{item}"
        end
    end
end

class Emotions
    attr_reader :feelings

    def initialize(*feelings)
        @feelings = feelings
    end
end

class InvalidArgument < StandardError
    def message
        return "Invalid command line argument, valid arguments are as follows:
        '-n' for new entry
        '-v' to view entries
        '-s' to search entires"
    end
end

class NoEntriesError < StandardError
    def message
        return "There are no journal entries yet"
    end
end