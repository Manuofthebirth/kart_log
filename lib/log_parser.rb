# Opening log file

class LogParser
	attr_reader :raw_log
	
	def initialize(log_text)
		@raw_log = log_text
	end

	def lap_logs
		raw_log.scan(/^\d\S*\s+\d+\s–\s\w.\w+\s+\d\s+\d:\d+.\d+\s+\d+,\d+$/m) # defining a racer's lap
	end

	def laps
		lap_logs.map { |lap_log| Lap.new(lap_log) } # will return an array with each lap log
	end
end
