# class Menu
#     attr_reader :menu_args
    
#     def initialize(*menu_args)
#         @menu_args = menu_args
#     end

#     #Prints menu
#     def display_menu
#         puts "Please select an option (1 to #{@menu_args.length})"
#         puts "Enter \"help\" to see options again"
#         @menu_args.each_with_index do |item, index|
#             puts "#{index + 1}. #{item}"
#         end
#     end

#     def input_check
#         input = ARGV[0]
#         unless input.to_i.between?(0, @menu_args.length) == true || input == "help"
#             raise InvalidOptionError
#         end
#     end
# end

# main_menu = Menu.new("New Journal Entry", "View All Journal Entries", "Search Journal Entries", "Exit")

# puts main_menu.menu_args do

a = "hello"

def poo
    puts a
end


