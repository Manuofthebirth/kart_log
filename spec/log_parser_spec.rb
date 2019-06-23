require 'spec_helper'
require 'pry-byebug'
require 'log_parser'
require 'race'

describe LogParser do
  subject(:log) { LogParser.new(File.open('log/kart.log').read) } # for repeated test lines

  it 'should initialize with a log' do
    expect { log }.not_to raise_error
  end

  describe '#raw_log' do
    it 'returns the raw log text' do
      log_string = File.open('log/kart.log').read
      # binding.pry
      expect(log.raw_log).to eq(log_string)
    end
  end

  describe '#lap_logs' do
    it 'returns separate lap logs correctly' do
      lap1_string = File.open('log/lap_test1.txt').read
      lap3_string = File.open('log/lap_test2.txt').read
      # binding.pry
      expect(log.lap_logs[0]).to eq(lap1_string)
      expect(log.lap_logs[3]).to eq(lap3_string)
    end
  end

  describe '#laps' do
    it 'returns an array of laps from a Race' do
      expect(log.laps[0]).to be_a(Race)
    end
  end
end