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
      puts "\nHere's what you're looking for:"
      puts ''
      command(number)
      answer = gets.chomp.upcase
      if answer == 'N'
        break
      end
      repeat(answer)
    end
  end

  def print_commands # available commands
  	puts "\n***************************************"
    puts "1 - Racer's positions"
    puts "2 - Racer's total time"
    puts "3 - Racer's best laps"
    puts "4 - Race's best lap"
    puts "5 - Racer's average speed"
    puts "6 - Racer's time after winner"
    puts '***************************************'
  end

  def command(number) # Race class methods
  	case number
  	when "1" then puts @race.results
    when "2" then puts @race.total_time
    when "3" then puts @race.best_laps_results
    when "4" then puts @race.best_lap 
    when "5" then puts @race.avg_speed
    when "6" then puts @race.time_after_winner
    else
  	  puts "\nBzzt! Wrong command!"
  	end
    puts "\nContinue? Type N if you want to exit."
  end

  def repeat(answer) # restart loop
    puts "What do you want to do?"
  end
end