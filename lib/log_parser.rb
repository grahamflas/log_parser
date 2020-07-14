require 'pry'

class LogParser
  attr_accessor :logs, :output
  def initialize
    @logs = []
    @output = []
  end

  def run
    read_logs
    binding.pry
  end

  def read_logs
    File.foreach(ARGV.first) { |line| logs << line.chomp }
  end
  
end
