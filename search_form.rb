require 'mechanize'
require_relative 'flight_info'

URL = 'https://www.southwest.com/flight/search-flight.html'
FORM_NAME = 'buildItineraryForm'
SEARCH_RESULTS_ID = 'searchResults'

class SearchForm
	def initialize(options)
		@options = options
	end

  def search
		agent = Mechanize.new

		# Get the page
		page = agent.get URL

		# Fill out the search form
		form = page.form(FORM_NAME)
		form.originAirport = @options[:orig]
		form.radiobuttons_with(:name => 'twoWayTrip')[0].check
		form.destinationAirport = @options[:dest]
		form.outboundDateString = @options[:depart_date]
		form.returnDateString = @options[:return_date]
		page = form.submit

		# Pick out the desired flights from the search results
		results = page.form(SEARCH_RESULTS_ID)
		flights_from results
  end

  private

   def flights_from(results)
		results.radiobuttons_with(:name => /boundTrip/).each_with_object([]) do |entry, memo|
		  memo.push(FlightInfo.create_from(entry.value.split(','), entry.node.attributes['title']))
		end.compact
   end
end