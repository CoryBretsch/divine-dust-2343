class AirlinesController < ApplicationController 
  def show 
    @adult_passengers = Passenger.adult_passenger_list
  end
end