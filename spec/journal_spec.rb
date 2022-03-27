require './journal.rb'

describe MenuOption do
    it 'can be instantiated' do
        option1 = MenuOption.new("New Journal Entry")
        expect(option1).not_to be_nil
    end
end