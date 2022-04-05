## About
This application is designed to allow users to document the everyday events  of their lives in the form of a interactive journal. 

## Features
- Allow users to create new journal entries comprised of a title, date, feeling, feeling intensity from 1 to 5 and main body and saves them to text files in the Entries folder.
- Assigns a unique ID to each journal entry and saves the information to JSON file
- Sa
- Allow users to view all previously written journal entries 

For the purposes of feature demonstration, the Entries folder and journal_index.json have been prepopulated with mock journal entries with titles comprised of fruits, dates ranging from 2020 to 2021 and randomly selected feelings and feeling intensities. 

## Dependencies
This application has been written in the Ruby programming language and thus requires Ruby to be installed. Refer to https://www.ruby-lang.org/en/ for installation instructions.

It also relies of the following third party Ruby Gems:
- uuidtools ~> 2.2
- fileutils ~> 2.2
- tty-prompt ~> 0.23.1
- awesome_print ~> 1.9
- colorize ~> 0.8.1
