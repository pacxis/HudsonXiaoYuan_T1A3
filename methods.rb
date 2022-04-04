require 'tty-prompt'



def display_entry(ent, options)
    prompt = TTY::Prompt.new
    selection = prompt.ask("Enter the Journal Entry number you would like to view: ") do |num|
                    num.in "1-#{ent.length}"
                    num.messages[:range?] = "Invalid journal entry selection, input a number from 1 to #{ent.length}"
    end
    system "clear"
    puts File.readlines("Entries/#{ent[selection.to_i - 1][:id]}.txt")
    return prompt.select("What would you like to do?", options)
end

def get_date(xyz, range)
    prompt = TTY::Prompt.new
    prompt.ask("Input the #{xyz}: ") do |a|
        a.convert :int
        a.in range
        a.messages[:range?] = "Invalid input, select a number from #{range}"
    end
end
   