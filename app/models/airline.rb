class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights

  def adult_passenger_list
    passengers.where("passengers.age>=18").distinct
  end
  
end