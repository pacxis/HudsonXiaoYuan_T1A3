day = rand(1..30).to_s
month = rand(1..12).to_s
year = rand(2020..2021).to_s
date = "#{day}/#{month}/#{year}"
        title = "unsure what happened today"
        feeling = "unsure"
        intensity = rand(1..5)
# intensity = 0
        id = UUIDTools::UUID.timestamp_create.to_s
        entry = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus augue sit amet tincidunt ornare. Donec nec venenatis nisl, rutrum scelerisque nibh. Sed a tincidunt felis. Praesent rutrum semper fringilla. Donec hendrerit nulla sed ultrices efficitur. Nullam sit amet molestie nibh. Quisque eget ornare lectus. Proin in accumsan lectus. Pellentesque lectus orci, accumsan id diam et, volutpat aliquam lorem. Integer consequat faucibus ullamcorper. Nulla interdum accumsan quam, sit amet condimentum erat blandit ut."
        file = File.open("#{id}.txt", 'w')
        FileUtils.mv("#{id}.txt", "Entries/#{id}.txt")
        file << title + "\n"*2
        file << date + "\n"*2
        file << feeling + " (#{intensity})" + "\n"*2
        file << entry
        entry_info = { title: title, id: id, feeling: feeling, intensity: intensity, year: year.to_i, month: month.to_i, day: day.to_i }
        File.open('journal_index.json', 'w') do |f|
            f.puts JSON.pretty_generate(j_index << entry_info)
        end
        file.close
