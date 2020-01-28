# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'time'

Airport.create([
    { code: 'RDU', country: 'US', city: 'Raleigh' },
    { code: 'LGA', country: 'US', city: 'New York'},
    { code: 'LHR', country: 'UK', city: 'London'}
])

Aircraft.create([
    { aircraft_no: 'NAA123', manufacturer: 'Boeing', capacity: 200 },
    { aircraft_no: 'CMA789', manufacturer: 'Airbus', capacity: 300 },
    { aircraft_no: 'NIK056', manufacturer: 'Small Plane Man', capacity: 100 },
])

Flight.create([
    { flight_no: '123abc456', origin: 'RDU', destination: 'LHR', start_date: Time.now, end_date: Time.now },
    { flight_no: '123xyz456', origin: 'LHR', destination: 'RDU', start_date: Time.now, end_date: Time.now }
])