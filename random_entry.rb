require 'date'
require 'tty-prompt'
# day = rand(1..30)
# if day.between?(1, 9)
#     day = '0' + day.to_s
# end
# month = rand(1..12)
# if month.between?(1, 9)
#     month = '0' + month.to_s
# end
# year = rand(2020..2021).to_s
# date = "#{day}/#{month}/#{year}"
# feel = ["happy", "sad", "anxious", "stressed", "suprised", "confused", "angry"]
# fruits = ["apple", "pear", "raspberry", "blueberry", "lemon", "cherry", "orange", "grapefruit", "kiwifruit", "tomato", "watermelon", "papaya", "pineapple", "strawberry", "persimmon", "plum", "peach", "mandarin", "tangerine", "banana", "coconut", "apricot", "cranberry", "grapes", "guava", "lychee", "mango", "passion fruit"]
#         title = fruits.sample
#         # feeling = feel.sample
#         feeling = "okay"
#         # intensity = rand(1..5)
# intensity = 0
#         id = UUIDTools::UUID.timestamp_create.to_s
#         entry = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus augue sit amet tincidunt ornare. Donec nec venenatis nisl, rutrum scelerisque nibh. Sed a tincidunt felis. Praesent rutrum semper fringilla. Donec hendrerit nulla sed ultrices efficitur. Nullam sit amet molestie nibh. Quisque eget ornare lectus. Proin in accumsan lectus. Pellentesque lectus orci, accumsan id diam et, volutpat aliquam lorem. Integer consequat faucibus ullamcorper. Nulla interdum accumsan quam, sit amet condimentum erat blandit ut."
#         file = File.open("#{id}.txt", 'w')
#         FileUtils.mv("#{id}.txt", "Entries/#{id}.txt")
#         file << title + "\n"*2
#         file << date + "\n"*2
#         file << feeling + " (#{intensity})" + "\n"*2
#         file << entry
#         entry_info = { title: title, id: id, date: date, feeling: feeling, intensity: intensity }
#         File.open('journal_index.json', 'w') do |f|
#             f.puts JSON.pretty_generate(j_index << entry_info)
#         end
#         file.close
#         exit
j_index = [
  {
    "title": "tomato",
    "id": "deez",
  },
  {
    "title": "apricot",
    "id": "pobe",
  }
]


# a.delete_at(index(a.select{ |t| t[:id] == )

# puts a.index(a.select{ |t| t[:id] == "deez" } )



# puts .index{ |t| t[:id] == "deez" }
# puts "bun"

c = "pro skater"
if c.include? "pro"
    puts "true"
end