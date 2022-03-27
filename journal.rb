
# file = File.open("#{title}.txt", 'w')
# file.close

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
        @menu_args.each_with_index do |item, index|
            puts "#{index + 1}. #{item}"
        end
        puts "Please select an option (1 to #{@menu_args.length})"
    end

    def selection
        input = ARGV[0].to_i
        unless input.between?(1, @menu_args.length) == true
            raise InvalidOptionError
        end
        return input
    end
        
end

main_menu = Menu.new("New Journal Entry", "View All Journal Entries", "Search Journal Entries", "Exit")

main_menu.display_menu

main_menu.selection

puts input




# def gets_selection
#     unless selection.between?(1..menu.length)
#         raise(InvalidOptionError)
#     end
# end


# case selection
# when 1
#     puts "1"
# when 2
#     puts "2"
# when 3
#     puts "3"
# when 4
#     puts "4"
# end
# rescue InvalidOptionError => e
#     puts e.message
#     retry

