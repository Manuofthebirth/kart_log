
class Lap
	attr_accessor :lap_info

	def initialize(lap_log_text)
		@lap_info = lap_log_text
	end

  def lap_stats 
    # extracting an array with each value from a lap
    lap_info.scan(/^(?<hourinput>\d\S+)\s+(?<code>\d+)\s–\s(?<racer>\w\S+)\s+(?<lap>\d)\s+(?<laptime>\d\S+)\s+(?<avgspd>\d\S+)/)
  end
end
    log_string.scan(/^(?<hourinput>\d\S+)\s+(?<code>\d+)\s–\s(?<racer>\w\S+)\s+(?<lap>\d)\s+(?<laptime>\d\S+)\s+(?<avgspd>\d\S+)/).sort_by { |x| x[3] }
