class TripsController < ApplicationController
  def index

    render "trips/index"

  end

  def search
    p params
    render 'trips/works'
  end

  def flight
    @flights
    render json: @flights
  end

end

