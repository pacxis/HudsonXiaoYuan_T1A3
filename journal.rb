
# file = File.open("#{title}.txt", 'w')
# file.close

# class MenuOption
#     def initialize(option)
#         @option = option
#     end

# end

# MenuOption.new("New Journal Entry")

class Menu
    
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
end

menu = Menu.new("New Journal Entry", "View All Journal Entries", "Search Journal Entries", "Exit")

menu.display_menu

case ARGV[0]
when 1
end
when 2
end
when 3
end
when 4
end
else
    
