require 'ipaddress'
require 'json'

class Event
  @@events = []

  def self.all
    @@events
  end

  def self.summaries
    summaries = self.all.map { |e| e.summarize }
    summaries.each { |s| puts s }
    summaries
  end

  attr_reader :event_log, :source_ip, :destination_ip,
              :source_ip_valid, :destination_ip_valid,
              :source_ip_is_private, :destination_ip_is_private

  def initialize(event_log)
    @event_log = event_log
    @source_ip = parse_src(event_log)
    @destination_ip = parse_dst(event_log)
    @source_ip_valid = validate(source_ip)
    @destination_ip_valid = validate(destination_ip)
    @source_ip_is_private = is_private?(source_ip)
    @destination_ip_is_private = is_private?(destination_ip)
    save
  end

  def save
    @@events << self
  end

  def summarize
    {
      source_ip: source_ip,
      destination_ip: destination_ip,
      source_ip_valid: source_ip_valid,
      destination_ip_valid: destination_ip_valid,
      source_ip_is_private: source_ip_is_private,
      destination_ip_is_private: destination_ip_is_private,
    }.to_json
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
