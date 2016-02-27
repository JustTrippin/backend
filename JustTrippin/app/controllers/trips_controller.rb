class TripsController < ApplicationController
  def index


    @response = HTTParty.post("http://terminal2.expedia.com:80/x/flights/overview/get",
      :body => {
    "MessageHeader": { "ClientInfo": { "DirectClientName": "Hackathon"}, "TransactionGUID": ""},
    "tpid": 1, "eapid": 0, "PointOfSaleKey": { "JurisdictionCountryCode": "USA", "CompanyCode": "10111", "ManagementUnitCode": "1010" },

    "OriginAirportCodeList": {
    "AirportCode": ["JFK"]
    },
    "DestinationAirportCodeList": {
    "AirportCode": ["SFO", "OAK"]
    },

    "FlightListings": { }
    }
    .to_json,
    :headers => { 'Content-Type' => 'application/json',
                  'Accept' => 'application/json',
                'Authorization' => ENV['EXPEDIA_SECRET_KEY']

                }
      )


    render json: @response

  end
end
