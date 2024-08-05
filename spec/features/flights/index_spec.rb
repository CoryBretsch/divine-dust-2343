require "rails_helper"

RSpec.describe "flights index page" do 
  describe "user story 1" do 
    it "can list all flight numbers, airline name, passengers names" do 
      @airline = Airline.create!(name: "Spirit")
      @flight1 = @airline.flights.create!(number: 735, 
                                        date: "05/10/24", 
                                        departure_city: "Nashville",
                                        arrival_city: "New York")
      @flight2 = @airline.flights.create!(number: 346, 
                                        date: "08/10/24", 
                                        departure_city: "San Diego",
                                        arrival_city: "Milwaukee")
      @passenger1 = Passenger.create!(name: "Diane", age: 87)
      @passenger2 = Passenger.create!(name: "Laura", age: 63)
      @passenger3 = Passenger.create!(name: "Dora", age: 12)
      @passenger4 = Passenger.create!(name: "Millie", age: 38)
      @passenger5 = Passenger.create!(name: "Leah", age: 10)
      @passenger6 = Passenger.create!(name: "Humphry", age: 6)
      FlightPassenger.create!(flight: @flight1, passenger: @passenger1)
      FlightPassenger.create!(flight: @flight1, passenger: @passenger2)
      FlightPassenger.create!(flight: @flight1, passenger: @passenger3)
      FlightPassenger.create!(flight: @flight2, passenger: @passenger4)
      FlightPassenger.create!(flight: @flight2, passenger: @passenger5)
      FlightPassenger.create!(flight: @flight2, passenger: @passenger6)

      visit flights_path

      expect(page).to have_content("#{@flight1.number} - operated by: #{@flight1.airline_name}")
      expect(page).to have_content("#{@flight2.number} - operated by: #{@flight2.airline_name}")

      within ".flight-#{@flight1.id}" do 
        expect(page).to have_content(@passenger1.name)
        expect(page).to have_content(@passenger2.name)
        expect(page).to have_content(@passenger3.name)
      end

      within ".flight-#{@flight2.id}" do 
        expect(page).to have_content(@passenger4.name)
        expect(page).to have_content(@passenger5.name)
        expect(page).to have_content(@passenger6.name)
      end
    end
  end

  describe "user story 2" do 
    it "can remove a passenger from a flight" do 
      @airline = Airline.create!(name: "Spirit")
      @flight1 = @airline.flights.create!(number: 735, 
                                        date: "05/10/24", 
                                        departure_city: "Nashville",
                                        arrival_city: "New York")
      @flight2 = @airline.flights.create!(number: 346, 
                                        date: "08/10/24", 
                                        departure_city: "San Diego",
                                        arrival_city: "Milwaukee")
      @passenger1 = Passenger.create!(name: "Diane", age: 87)
      @passenger2 = Passenger.create!(name: "Laura", age: 63)
      @passenger3 = Passenger.create!(name: "Dora", age: 12)
      @passenger4 = Passenger.create!(name: "Millie", age: 38)
      @passenger5 = Passenger.create!(name: "Leah", age: 10)
      @passenger6 = Passenger.create!(name: "Humphry", age: 6)
      FlightPassenger.create!(flight: @flight1, passenger: @passenger1)
      FlightPassenger.create!(flight: @flight1, passenger: @passenger2)
      FlightPassenger.create!(flight: @flight1, passenger: @passenger3)
      FlightPassenger.create!(flight: @flight2, passenger: @passenger1)
      FlightPassenger.create!(flight: @flight2, passenger: @passenger5)
      FlightPassenger.create!(flight: @flight2, passenger: @passenger6)

      visit flights_path

      within ".flight-#{@flight1.id}" do 
        expect(page).to have_content(@passenger1.name)
        expect(page).to have_content(@passenger2.name)
        expect(page).to have_content(@passenger3.name)
      end

      within ".flight-#{@flight2.id}" do 
        expect(page).to have_content(@passenger1.name)
        expect(page).to have_content(@passenger5.name)
        expect(page).to have_content(@passenger6.name)
      end
      
      within ".flight-#{@flight1.id}" do
        within "#passenger-#{@passenger1.id}" do 
          click_on "Remove Passenger"
        end

        expect(page).to_not have_content(@passenger1.name)
        expect(page).to have_content(@passenger2.name)
        expect(page).to have_content(@passenger3.name)
      end
    
      within ".flight-#{@flight2.id}" do 
        expect(page).to have_content(@passenger1.name)
        expect(page).to have_content(@passenger5.name)
        expect(page).to have_content(@passenger6.name)
      end

    end
  end

end