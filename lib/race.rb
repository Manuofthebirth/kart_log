require_relative "log_parser" 

class Race
	attr_accessor :laps_info

	def initialize(lap_log_text)
		@laps_info = lap_log_text
	end

  def lap_stats 
    # extracting each information from a lap to an array
    # hour input, racer code, racer name, lap #, lap time and average speed
    laps_info.scan(/^(?<hourinput>\d\S+)\s+(?<code>\d+)\s–\s(?<racer>\w\S+)\s+(?<lap#>\d)\s+(?<laptime>\d\S+)\s+(?<avgspeed>\d\S+)/)
  end

  def last_laps 
    first_laps = lap_stats.sort_by { |x| x[3] } # first lap to last from each racer (sorted by lap #)
    first_laps.reverse.uniq{ |x| x[1] } # reverse order (last lap to first) + keep only last laps from each racer
  end

  def racer_positions
    last_laps.sort_by { |x| x[0] } # last lap finish sorted by hour input
  end

  def racer_stats # extract informations from the racers positions to an array of hashes
    racer_positions.map do |hour, code, name, laps|
      { racer_name: name, racer_code: code, laps_completed: laps }
    end
  end

  def results
    racer_stats.each_with_index do |(racer_stat), index|
      puts "Position ##{index + 1}"
      puts "Racer: #{racer_stat[:racer_code]} – #{racer_stat[:racer_name]}"
      # puts "Racer Code: #{racer_stat[:racer_code]}"
      puts "Laps Completed: #{racer_stat[:laps_completed]}"
      puts ''
    end
  end

  # Bonus - Best Lap

  def best_laps # lap times ordered from best to worst
    # racer code, racer name, lap #, lap time
    laps_info.scan(/^\d\S+\s+(?<code>\d+)\s–\s(?<racer>\w\S+)\s+(?<lap#>\d)\s+(?<laptime>\d\S+)/).sort_by { |x| x[3] }
  end

  def best_by_racers
    best_laps.uniq{ |x| x[0] } # best lap time from each racer
  end

  def best_lap 
    best = best_laps.first # best lap overall
    puts "The best lap is from Racer #{best[1]} with a time of '#{best[3]}' in his lap ##{best[2]}"
  end

  def best_laps_stats # extract informations to an array of hashes
    best_by_racers.map do |code, name, laps, laptime|
      { racer_name: name, best_lap: laps, lap_time: laptime }
    end 
  end

  def best_laps_results
    best_laps_stats.each do |best_laps_stat|
      puts "Racer: #{best_laps_stat[:racer_name]}"
      puts "Best Lap: ##{best_laps_stat[:best_lap]}"
      puts "Lap Time: #{best_laps_stat[:lap_time]}"
      puts ''
    end
  end

  # Bonus - Avg Speed + Race Total Time 

  def speed_stats # extract informations to an array of hashes
    lap_stats.map do |hour, code, name, laps, laptime, avgspd|
      { racer_name: name, racer_code: code, laptime: laptime, avgspd: avgspd}
    end
  end

  def time_by_racers # lap times speed from each racer
    speed_stats.group_by{|h| h[:racer_name]}.each{|_, v| v.map!{|h| h[:laptime]}}
  end  

  def time_to_int
    # turn time strings to integer
    int = []
    time_by_racers.each do |key, value|
      value.each do |v|
        str = v.split('')
        str.delete_at(1)
        str.delete_at(3)
        int = str.join
        puts int.to_f
      end
    end
  end
        # puts "Racer #{key} had a total time of #{int}"

  def speed_by_racers # avg speed from each racer
    speed_stats.group_by{|h| h[:racer_name]}.each{|_, v| v.map!{|h| h[:avgspd]}}
  end

  def avg_speed
    speed_by_racers.each do |racer, speed|
      lap_avgs = []
      speed.each do |s|
        # turn speed strings to integer and divide by number of laps completed then convert it back
        speed_string = s.split('')
        speed_string.delete_at(2)
        s = speed_string.join
        lap_avgs << s.to_i
        s = lap_avgs.inject{ |sum, x| sum + x }
        average_spd = s/lap_avgs.count
        speed = average_spd.to_s
        speed.insert(-4, ",")
      end
      puts "Racer #{racer} had an average speed of #{speed}"
    end
  end
end

# Posição Chegada, Código Piloto, Nome Piloto, 
# Qtde Voltas Completadas e Tempo Total de Prova.

# A corrida termina quando o primeiro colocado completa 4 voltas

# Bonus

# Descobrir a melhor volta de cada piloto
# Descobrir a melhor volta da corrida
# Calcular a velocidade média de cada piloto durante toda corrida
# Descobrir quanto tempo cada piloto chegou após o vencedor

# Tempo Total de Prova

# str1 = "1:02.852"

# str2 = str1.split('')
# str2.delete_at(1)
# str2.delete_at(3)
# str1 = str2.join

# str2 = str1.split('')
# str2.insert(-6, ":") 
# str2.insert(-4, ".")
# str1 = str2.join
