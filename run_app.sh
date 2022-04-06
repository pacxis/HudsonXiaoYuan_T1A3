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
read selection


if [ "-n" == $selection ];
then 
    ruby main.rb -n
elif [ "-v" == $selection ]
then
    ruby main.rb -v
elif [ "-s" == $selection ]
then
    ruby main.rb -s
elif [ "-r" == $selection ]
then
    ruby main.rb -r
else
    ruby main.rb
fi