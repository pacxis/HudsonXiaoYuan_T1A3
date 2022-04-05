require 'tty-prompt'

j_index = JSON.load_file('journal_index.json', symbolize_names: true)

def display_entry(ent, options, delete)
    m_selection = nil
    prompt = TTY::Prompt.new
    selection = prompt.ask("Enter the Journal Entry number you would like to view: ") do |num|
                    num.in "1-#{ent.length}"
                    num.messages[:range?] = "Invalid journal entry selection, input a number from 1 to #{ent.length}"
    end
    system "clear"
    puts File.readlines("Entries/#{ent[selection.to_i - 1][:id]}.txt")
    while m_selection != options[-1]
        m_selection = prompt.select("What would you like to do?", options)
            if m_selection == options[1] && prompt.yes?("Are you sure you want to delete this entry?")
                File.delete("Entries/#{ent[selection.to_i - 1][:id]}.txt")

end

def get_date(xyz, range)
    prompt = TTY::Prompt.new
    prompt.ask("Input the #{xyz}: ") do |a|
        a.convert :int
        a.in range
        a.messages[:range?] = "Invalid input, select a number from #{range}"
    end
end
   