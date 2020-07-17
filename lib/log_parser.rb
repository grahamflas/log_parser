require_relative './event.rb'
require 'pry'

class LogParser
  def run
    read_logs
    write_to_file
  end

  def read_logs
    File.foreach(ARGV.first) { |line| Event.new(line.chomp) if line.start_with?(/<\d+>/) }
  end

  def write_to_file
    file = File.new('output.txt', 'w')

    File.open('output.txt', 'w') do |f|
      Event.summaries.each { |e| f.write e + "\n" }
    end

    file.close
  end
end
