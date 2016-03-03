require 'rubygems'
require 'optparse'
require_relative 'search_form'
require_relative 'flight_info'

options = {:orig => nil, :dest => nil, :depart_date => nil, :return_date => nil}

parser = OptionParser.new do |opts|
  opts.banner = "Usage: southwest.rb [options]"
    
  opts.on('--orig n') do |originAirport|
	  options[:orig] = originAirport
  end

  opts.on('--dest n') do |destAirport|
    options[:dest] = destAirport
  end

  opts.on('--depart_date n') do |date|
    options[:depart_date] = date
  end

  opts.on('--return_date n') do |date|
    options[:return_date] = date
  end
end

parser.parse!

flights = SearchForm.new(options).search

if flights.empty?
  puts "No Flight Results :("
else
  puts "Your flight results from " + options[:orig] + " to " + options[:dest]
  flights.each do |flight|
    puts flight.to_s
  end
  puts "="*80
end
