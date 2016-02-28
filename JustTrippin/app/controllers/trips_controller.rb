class TripsController < ApplicationController
  def index
    render 'trips/index'

  end

  def pizza
    bar = Trip.new("SFO", "West", 200)
    bar.cities("West")
    @beast = bar.overview
    render json: @beast

  end

end

