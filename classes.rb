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