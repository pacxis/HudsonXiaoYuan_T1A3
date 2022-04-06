require './classes.rb'

describe Menu do
    it 'can be instantiated' do
        my_menu = Menu.new("New Journal Entry")
        expect(my_menu).not_to be_nil
        expect(my_menu).to be_an_instance_of Menu
    end
end

describe Emotions do
    it 'can be instantiated' do
        my_feeling = Emotions.new("happy")
        expect(my_feeling).not_to be_nil
        expect(my_feeling).to be_an_instance_of Emotions
    end
end
