require './classes.rb'

describe Menu do
    it 'can be instantiated' do
        option1 = Menu.new("New Journal Entry")
        expect(option1).not_to be_nil
        expect(option1).to be_an_instance_of Menu
    end
end

describe Parameters do
    it 'searches journal index by specified parameters' do
        search = Parameters.new
        
