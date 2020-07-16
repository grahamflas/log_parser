require 'ipaddress'
require 'json'
require 'pry'


class LogParser
  attr_accessor :logs, :output

  KEYS = %w(
    source_ip
    destination_ip
    source_ip_valid
    destination_ip_valid
    source_ip_is_private
    destination_ip_is_private
  )

  def initialize
    @logs = []
    @output = []
  end

  def run
    read_logs
    parse_logs
    print_output
    write_to_file
  end

  def read_logs
    File.foreach(ARGV.first) { |line| logs << line.chomp if line.start_with?(/<\d+>/) }
  end

  def print_output
    output.each { |h| puts h.to_json }
  end

  def write_to_file
    file = File.new('output.txt', 'w')

    File.open('output.txt', 'w') do |f|
      output.each { |h| f.write h.to_json + "\n" }
    end

    file.close
  end

  def parse_logs
    logs.each do |l|
      source_ip = parse_src(l)
      destination_ip = parse_dst(l)

      source_ip_valid = validate(source_ip)
      destination_ip_valid = validate(destination_ip)

      source_ip_is_private = is_private?(source_ip)
      destination_ip_is_private = is_private?(destination_ip)

      hash = {}
      KEYS.each { |k| hash[k] = eval(k) }

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

  def validate(ip)
    IPAddress.valid? ip
  end

  def is_private?(ip)
    begin
      ip = IPAddress::IPv4.new(ip)
      ip.private?
    rescue ArgumentError
      false
    end
  end
end
