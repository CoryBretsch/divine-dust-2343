class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights

  # def adult_passenger_list
  #   names = []
  #   passengers.where("passengers.age>=18").each do |passenger|
  #     names << passenger.name
  #   end
  #   names.uniq
  # end

  def adult_passenger_list
    passengers.where("passengers.age>=18").distinct
  end
end