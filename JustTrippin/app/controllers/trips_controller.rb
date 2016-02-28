class TripsController < ApplicationController
  def index

    render "trips/index"

  end

  def search
    trip = Trip.new("SFO", "West", 200)
    trip.cities("West")
    @flights = trip.overview

  end

  def flight
    @flights
    render json: @flights
  end

end

