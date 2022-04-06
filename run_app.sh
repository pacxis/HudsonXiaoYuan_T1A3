#!/bin/bash

gem install bundler
bundle install
clear

printf "Welcome to the Journal App, what would you like to do?\n"
printf "    Enter '-n' to create a new journal entry\n";
printf "    Enter '-v' to view journal entries\n";
printf "    Enter '-s' to search journal entries\n";
printf "    Enter '-r' to reset journal\n";
printf "    Any other entry will open the main menu\n";
read -r selection

case $selection in
    -n)
        ruby main.rb -n
        ;;
    -v)
        ruby main.rb -v
        ;;
    -s)
        ruby main.rb -s
        ;;
    -r)
        ruby main.rb -r
        ;;
    *)
        ruby main.rb
esac