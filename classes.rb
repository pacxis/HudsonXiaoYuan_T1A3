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

class Parameters
    attr_accessor :title :feeling :intensity :year :month :date

    def initialize(title, feeling, intensity, year, month, day)
        @title = title
        @feeling = feeling
        @intensity = intensity
        @year = year
        @month = month
        @day = day
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

class InvalidDate < StandardError
    def message
        return "Invalid entry, must be an integer"
    end
end

class NoResultsError < StandardError
    def message
        return "No journal entries matched the specified search parameters"
    end
end