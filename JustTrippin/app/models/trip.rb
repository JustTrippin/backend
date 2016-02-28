class Trip < ActiveRecord::Base
    attr_accessor :origin, :destination, :budget
  def initialize(origin, destination, budget)
    @origin = origin
    @destination = destination
    @budget = budget
  end

  def cities(destination)
    case destination
    when "West"
      @cities = ["SEA","LAX","SFO"]
    when "Southwest"
      @cities = ["PHX","LAS"]
    when "Texas"
      @cities = ["DAL"]
    when "Midwest"
      @cities = ["CHX", "DET"]
    when "South"
      @cities = ["ATL"]
    when "New York"
      @cities = ["JFK"]
    when "New England"
      @cities = ["BOS"]
    end
    p @cities
  end

  def overview

      response = HTTParty.post("http://terminal2.expedia.com:80/x/flights/overview/get",
      :body => {
                "MessageHeader": { "ClientInfo": { "DirectClientName": "Hackathon"}, "TransactionGUID": ""},
                "tpid": 1, "eapid": 0, "PointOfSaleKey": { "JurisdictionCountryCode": "USA", "CompanyCode": "10111", "ManagementUnitCode": "1010" },

                "OriginAirportCodeList": {
                "AirportCode": [@origin]
                },
                "DestinationAirportCodeList": {
                "AirportCode": @cities
                },

                "FlightListings": { }
                }
                .to_json,
                :headers => { 'Content-Type' => 'application/json',
                              'Accept' => 'application/json',
                            'Authorization' => "expedia-apikey key=XoZ3sWgEgfKywboJaS4EvWePDTWsG4ym"

                }
      )

    overview_body = JSON.parse(response.body)
    fare_items = overview_body["FlightListings"]["AirOfferSummary"]
    @flights = []
    fare_items.each do |item|
      flight_info = [item["FlightPriceSummary"]["TotalPrice"],
                    item["FlightItinerarySummary"]["OutboundDepartureAirlineCode"],
                    item["FlightItinerarySummary"]["OutboundDepartureAirportCode"],
                    item["FlightItinerarySummary"]["InboundDepartureAirportCode"],
                    item["FlightItinerarySummary"]["OutboundDepartureTime"],
                    item["FlightItinerarySummary"]["InboundDepartureTime"],
                    item["AirProductToken"],
                    ]
      @flights.push(flight_info)
    end


  end

end
