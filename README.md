## About
This application is designed to allow users to document the everyday events  of their lives in the form of a interactive journal. 

## Features
- Allow users to create new journal entries comprised of a title, date, feeling, feeling intensity from 1 to 5 and main body and saves them to text files in the ```Entries``` folder.
- Assigns a unique ID to each journal entry and saves the information to the ```journal_index.json``` file.
- Allow users to view all previously written journal entries by date, feeling or title alphabetical order
- Allow users to set search parameters and view journal entries which match them
- Allow users to delete entries after viewing them
- Allow users to reset the app by deleting all journal entries

For the purposes of feature demonstration, the ```Entries``` folder and ```journal_index.json``` have been prepopulated with 52 mock journal entries with titles comprised of various fruits, dates ranging from 2020 to 2021 and randomly selected feelings and feeling intensities. The user can delete all of these by using the ```-r``` command line argument.

## Dependencies
This application has been written in the Ruby programming language and thus requires Ruby to be installed. Refer to https://www.ruby-lang.org/en/ for installation instructions.

It uses RSpec for testing.

It also relies of the following third party Ruby Gems which are installed using Bundler:
- uuidtools ~> 2.2
- fileutils ~> 2.2
- tty-prompt ~> 0.23.1
- awesome_print ~> 1.9
- colorize ~> 0.8.1

## System and Hardware Requirements
This Journal App will run on all modern systems which support shell script files. An internet connection is required to install dependencies. 

## Installation
Navigate to the main directory and run the ```./run_app.sh``` file. The app will then install Bundler and the required gems. 

## Using the App
After running the ```./run_app.sh``` file and installing the required gems, the app will accept the following command line arguments:
- ```-n``` to create a new journal entry
- ```-v``` to view all journal entries
- ```-s``` to search for specific journal entries
- ```-r``` to delete all journals and clear ```journal_index.json```

Leaving the input field empty or inputting any other argument will take the user to the main menu, where they can use the app via an interactive menu navigated using the arrow keys and enter key. 

## Implementation Plan
https://trello.com/b/dLxxrRvw/journal-terminal-app

## GitHub Repo
https://github.com/pacxis/T1A3
