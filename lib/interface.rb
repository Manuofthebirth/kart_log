require_relative 'log_parser'
require_relative 'race'
require_relative 'app'

parse = LogParser.new(File.open('log/kart.log').read) # open file
race = Race.new(parse.laps)
app = App.new(race)
app.run