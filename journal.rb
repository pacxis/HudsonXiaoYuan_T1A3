# case ARGV[0]
# when "-n"
#     return "hello"
# end


# file = File.open("#{title}.txt", 'w')
# file.close

class MenuOption
    def initialize(option)
        @option = option
    end

end

MenuOption.new("New Journal Entry")
MenuOption.new("f")