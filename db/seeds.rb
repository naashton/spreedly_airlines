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
    { flight_no: '123abc456', origin: 'RDU', destination: 'LHR', start_date: Time.strptime("2020-05-05 06:30 AM", "%Y-%m-%d %I:%M %p"), end_date: Time.strptime("2020-05-25 10:30 AM", "%Y-%m-%d %I:%M %p") },
    { flight_no: '123xyz456', origin: 'LHR', destination: 'RDU', start_date: Time.strptime("2020-12-13 04:30 PM", "%Y-%m-%d %I:%M %p"), end_date: Time.strptime("2020-12-25 12:30 PM", "%Y-%m-%d %I:%M %p")},
    { flight_no: 'CRZTRN920', origin: 'LHR', destination: 'RDU', start_date: Time.strptime("2020-12-30 11:45 AM", "%Y-%m-%d %I:%M %p"), end_date: Time.strptime("2021-01-14 7:30 AM", "%Y-%m-%d %I:%M %p")},
])

PaymentMethod.create([
    { primary_account_number: '1111111111111114', first_name: 'Joe', last_name: 'Heisman', expiration_date: Time.parse('2021-01-01') },
    { primary_account_number: '1234567890123456', first_name: 'Tim', last_name: 'Tebow', expiration_date: Time.strptime("2000-10-31", "%Y-%m-%d") },
    { primary_account_number: '4111111111111111', first_name: 'Ricky', last_name: 'Williams', expiration_date: Time.strptime("2100-10-31", "%Y-%m-%d") }, # Valid Visa card
    { primary_account_number: '4012888888881881', first_name: 'Dan', last_name: 'Marino', expiration_date: Time.strptime("2100-10-31", "%Y-%m-%d") }, # Invalid Visa card
])