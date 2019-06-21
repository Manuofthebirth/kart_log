require_relative "log_parser" 
require_relative "lap" 

class Race
	attr_accessor :racers, :racercodes

	def initialize(lap_log_text)
		@lap_info = lap_log_text
	end

  def racers_info
    lap_stats.map do |lap_stat|
      { code: lap_stat[1], racer: lap_stat[2] }
    end
  end

  def best_laps # descending order
    # code, racer, lap # and lap time
    log_string.scan(/^\d\S+\s+(?<code>\d+)\s–\s(?<racer>\w\S+)\s+(?<lap#>\d)\s+(?<laptime>\d\S+)/).sort_by { |x| x[3] }
  end

  def best_by_racers
    best_laps.uniq{ |x| x[0] } # best lap time from each racer
  end

  def race_results
  end
end



# Hora: /^\d\S*/
# Código piloto: /^\d\S*\s*(?<code>\d{3})/
# Racer: /–.(?<racer>\w.\w*)/
# Lap: /–\s\w.\w*\s+(?<lap>[\d])/
# Lap time: /–\s\w.\w*\s+\d\s+(?<laptime>\d\S*)/
# Avg time: /–\s\w.\w*\s+\d\s+\d\S*\s+(?<avgspeed>\d+,\d+)/

# Posição Chegada, Código Piloto, Nome Piloto, 
# Qtde Voltas Completadas e Tempo Total de Prova.

# A corrida termina quando o primeiro colocado completa 4 voltas

# Bonus

# Descobrir a melhor volta de cada piloto
# Descobrir a melhor volta da corrida
# Calcular a velocidade média de cada piloto durante toda corrida
# Descobrir quanto tempo cada piloto chegou após o vencedor