require_relative 'log_parser'
require_relative 'race'
require_relative 'app'

parse = LogParser.new(File.open('log/kart.log').read) # open file
race = Race.new(parse)
app = App.new(race)
puts "\nWelcome to the Kart Log challenge! What do you want to do?"
app.run
puts "\nBye bye!"