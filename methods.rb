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