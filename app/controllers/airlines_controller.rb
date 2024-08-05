class AirlinesController < ApplicationController 
  def show 
    @airline = Airline.find(params[:id])
    @adult_passengers = @airline.adult_passenger_list
  end
end