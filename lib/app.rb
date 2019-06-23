require_relative 'log_parser'
require_relative 'race'

class App
  attr_accessor :race

  def initialize(race)
    @race = race
  end

  def run
    loop do
      print_commands
      number = gets.chomp
      action(number)
      if number == '7'
        break
      else
        puts ''
        puts "Here's what you're looking for:"
        puts ''
      end
    end
    puts "Bye bye!"
  end

  def print_commands
  	puts "\n**********************************************************"
    puts "Welcome to the Kart Log challenge! What do you want to do?"
    puts "1 - Race positions"
    puts "2 - Racer's total time"
    puts "3 - Racer's best laps"
    puts "4 - Race best lap"
    puts "5 - Racer's average speed in the race"
    puts "6 - Racer's race time after winner"
    puts "7 - Exit"
    puts '**********************************************************'
  end

  def action(number)
  	case number
  	when "1" then puts @race.results
    when "2" then puts @race.total_time
    when "3" then puts @race.best_laps_results
    when "4" then puts @race.best_lap 
    when "5" then puts @race.avg_speed
    when "6" then puts @race.time_after_winner
  	else
  	  puts "Wrong action"
  	end
  end
end