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
    last_laps.sort_by { |x| x[0] } # last lap sorted by hour input
  end

  def racer_stats # extract informations from the racers last laps to an array of hashes
    racer_positions.map do |hour, code, name, laps|
      { hour_input: hour, racer_name: name, racer_code: code, laps_completed: laps }
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

  # Race Total Time 

  def speed_stats # extract informations to an array of hashes
    lap_stats.map do |hour, code, name, laps, laptime, avgspd|
      { racer_name: name, racer_code: code, laptime: laptime, avgspd: avgspd}
    end
  end

  def time_by_racers # lap times + laps avg speed from each racer
    speed_stats.group_by{|h| h[:racer_name]}.each{|_, v| v.map!{|h| h[:laptime]}}
  end  

  def total_time
    # convert time strings to integer and sum the values; convert it back to string
    time_by_racers.each do |racer, time|
      lap_times = []
      time.each do |t|
        time_string = t.split('')
        time_string.delete_at(1)
        time_string.delete_at(3)
        t = time_string.join
        lap_times << t.to_i
        t = lap_times.inject{ |sum, x| sum + x }
        time = t.to_s
        time.insert(-6, ":")
        time.insert(-4, ".") 
      end
      puts "Racer #{racer} had a total time of '#{time}' during the race."
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

  # Bonus - Avg Speed

  def speed_by_racers # avg speed from each racer
    speed_stats.group_by{|h| h[:racer_name]}.each{|_, v| v.map!{|h| h[:avgspd]}}
  end

  def avg_speed # convert speed strings to integer and divide by number of occurences (laps); convert it back to string
    speed_by_racers.each do |racer, speed|
      lap_avgs = []
      speed.each do |s|
        speed_string = s.split('')
        speed_string.delete_at(2)
        s = speed_string.join
        lap_avgs << s.to_i
        s = lap_avgs.inject{ |sum, x| sum + x }
        average_spd = s/lap_avgs.count
        speed = average_spd.to_s
        speed.insert(-4, ",")
      end
      puts "Racer #{racer} had an average speed of #{speed} during the race."
    end
  end

  # Bonus - Time after Winner

  def last_by_racers # last hour input from each racer
    racer_stats.group_by{|h| h[:racer_name]}.each{|_, v| v.map!{|h| h[:hour_input]}}
  end

  def time_after_first
    last_by_racers.each do |racer, time|
      hour_inputs = []
      time.each do |t|
        time_string = t.split('')
        time_string.delete_at(8)
        time_string.delete_at(5)
        time_string.delete_at(2)
        t = time_string.join
        hour_inputs << t.to_f
        t = hour_inputs.inject { |x| x }
        time = (t - 235217003)/1000
      end
      puts "Racer #{racer} took a total time of '#{time}' seconds to finish the race after the winner."
    end
  end
end


