require 'fileutils'

file = File.new("hello.txt", 'w+')
FileUtils.move("hello.txt", "/Entries/hello.txt")