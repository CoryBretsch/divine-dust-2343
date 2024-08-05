require "rails_helper"

RSpec.describe "Airline's Show Page" do 
  describe "user story 3" do
    it "can produce a uniq list of all adult passengers on airline" do 
      @airline1 = Airline.create!(name: "Spirit")
      @flight1 = @airline1.flights.create!(number: 735, 
                                        date: "05/10/24", 
                                        departure_city: "Nashville",
                                        arrival_city: "New York")
      @flight2 = @airline1.flights.create!(number: 346, 
                                        date: "08/10/24", 
                                        departure_city: "San Diego",
                                        arrival_city: "Milwaukee")
      @passenger1 = Passenger.create!(name: "Diane", age: 87)
      @passenger2 = Passenger.create!(name: "Laura", age: 63)
      @passenger3 = Passenger.create!(name: "Dora", age: 12)
      @passenger5 = Passenger.create!(name: "Leah", age: 10)
      @passenger6 = Passenger.create!(name: "Humphry", age: 6)
      FlightPassenger.create!(flight: @flight1, passenger: @passenger1)
      FlightPassenger.create!(flight: @flight1, passenger: @passenger2)
      FlightPassenger.create!(flight: @flight1, passenger: @passenger3)
      FlightPassenger.create!(flight: @flight2, passenger: @passenger1)
      FlightPassenger.create!(flight: @flight2, passenger: @passenger5)
      FlightPassenger.create!(flight: @flight2, passenger: @passenger6)

      @airline2 = Airline.create!(name: "United")
      @flight3 = @airline2.flights.create!(number: 73, 
                                        date: "05/15/24", 
                                        departure_city: "Nashville",
                                        arrival_city: "New York")
      @passenger7 = Passenger.create!(name: "Humphry", age: 6)
      @passenger8 = Passenger.create!(name: "Snoy", age: 26)
      FlightPassenger.create!(flight: @flight3, passenger: @passenger7)
      FlightPassenger.create!(flight: @flight3, passenger: @passenger8)

      visit airline_path(@airline1)

      expect(page).to have_content(@passenger1.name)
      expect(page).to have_content(@passenger2.name)

      expect(page).to_not have_content(@passenger3.name)
      expect(page).to_not have_content(@passenger5.name)
      expect(page).to_not have_content(@passenger6.name)
    end
  end
end