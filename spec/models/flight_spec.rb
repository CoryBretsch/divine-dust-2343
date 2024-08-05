require "rails_helper"

RSpec.describe Flight, type: :model do
  describe "relationships" do
    it { should belong_to :airline }
    it { should have_many :flight_passengers }
    it { should have_many(:passengers).through(:flight_passengers) }
  end

  describe "instance methods" do 
    it "can return flights #airline_name" do 
    @airline = Airline.create!(name: "Spirit")
    @flight1 = @airline.flights.create!(number: 735, 
                                      date: "05/10/24", 
                                      departure_city: "Nashville",
                                      arrival_city: "New York")

      expect(@flight1.airline_name).to eq("Spirit")
    end
  end
end
