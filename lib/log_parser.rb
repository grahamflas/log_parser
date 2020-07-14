require 'pry'

class LogParser
  attr_accessor :logs, :output

  def initialize
    @logs = []
    @output = []
  end

  def run
    read_logs
    parse_logs
    print_output
  end

  def read_logs
    File.foreach(ARGV.first) { |line| logs << line.chomp if line.start_with?("<") }
  end

  def print_output
    puts output
  end

  def parse_logs
    logs.each do |l|
      source_ip = parse_src(l)
      destination_ip = parse_dst(l)
      
      hash = {}
      hash['source_ip'] = source_ip
      hash['destination_ip'] = destination_ip

      output << hash
    end
  end

  def parse_src(log)
    match = log.match(/src=(?<source_ip>(?:\d{1,3}\.){3}\d{1,3})/)
    match ? match[:source_ip] : nil
  end

  def parse_dst(log)
    match = log.match(/dst=(?<destination_ip>(?:\d{1,3}\.){3}\d{1,3})/)
    match ? match[:destination_ip] : nil
  end
end
