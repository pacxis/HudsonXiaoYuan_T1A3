require 'json'

class Menu
    attr_reader :menu_items
    def initialize(*menu_items)
        @menu_items = menu_items
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

class InvalidTitleError < StandardError
    def message
        return "Title field cannot be empty"
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
