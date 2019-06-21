require_relative "log_parser" 

class Race
	attr_accessor :laps_info

	def initialize(lap_log_text)
		@laps_info = lap_log_text
	end

  def lap_stats 
    # extracting an array with each information from a lap
    # hour input, racer code, racer name, lap #, lap time and average speed
    laps_info.scan(/^(?<hourinput>\d\S+)\s+(?<code>\d+)\s–\s(?<racer>\w\S+)\s+(?<lap#>\d)\s+(?<laptime>\d\S+)\s+(?<avgspeed>\d\S+)/)
  end

  def last_laps 
    first_laps = lap_stats.sort_by { |x| x[3] } # first lap to last from each racer
    first_laps.reverse.uniq{ |x| x[1] } # reverse order (last lap to first) + keep only last laps from each racer
  end

  def racer_positions
    last_laps.sort_by { |x| x[0] } # last lap finish ordered by hour input
  end

  def racer_stats
    racer_positions.map do |hour, code, name, laps|
      { racer_name: name, racer_code: code, laps_completed: laps }
    end
  end

  def race_results
    racer_stats.each_with_index do |(racer_stat), index|
      puts "Position #{index + 1}"
      puts "Racer: #{racer_stat[:racer_name]}"
      puts "Racer Code: #{racer_stat[:racer_code]}"
      puts "Laps Completed: #{racer_stat[:laps_completed]}"
      puts ''
    end
  end

  # Bonus

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

  def best_laps_stats
    best_by_racers.map do |code, name, laps, laptime|
      { racer_name: name, best_lap: laps, lap_time: laptime }
    end 
  end

  def best_lap_results
    best_laps_stats.each do |best_laps_stat|
      puts "Racer: #{best_laps_stat[:racer_name]}"
      puts "Best Lap: ##{best_laps_stat[:best_lap]}"
      puts "Lap Time: #{best_laps_stat[:lap_time]}"
      puts ''
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