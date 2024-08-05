class FlightPassengersController < ApplicationController
  def destroy
    flight_passenger = FlightPassenger.where("flight_id=#{params[:id]} and passenger_id=#{params[:passenger_id]}")
    FlightPassenger.destroy(flight_passenger)
    redirect_to flights_path
  end
end