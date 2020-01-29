# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'time'

Flight.create([
    { flight_no: '123abc456', origin: 'RDU', destination: 'LHR', departure: Time.strptime("2020-05-05 06:30 AM", "%Y-%m-%d %I:%M %p"), arrival: Time.strptime("2020-05-25 10:30 AM", "%Y-%m-%d %I:%M %p"), price: 50000 },
    { flight_no: '123xyz456', origin: 'LHR', destination: 'RDU', departure: Time.strptime("2020-12-13 04:30 PM", "%Y-%m-%d %I:%M %p"), arrival: Time.strptime("2020-12-25 12:30 PM", "%Y-%m-%d %I:%M %p"), price: 100000},
    { flight_no: 'CRZTRN920', origin: 'LHR', destination: 'RDU', departure: Time.strptime("2020-12-30 11:45 AM", "%Y-%m-%d %I:%M %p"), arrival: Time.strptime("2021-01-14 7:30 AM", "%Y-%m-%d %I:%M %p"), price: 78000},
])

PaymentMethod.create([
    { primary_account_number: '1111111111111114', first_name: 'Joe', last_name: 'Heisman', expiration_date: Time.parse('2021-01-01') },
    { primary_account_number: '1234567890123456', first_name: 'Tim', last_name: 'Tebow', expiration_date: Time.strptime("2000-10-31", "%Y-%m-%d") },
    { primary_account_number: '4111111111111111', first_name: 'Ricky', last_name: 'Williams', expiration_date: Time.strptime("2100-10-31", "%Y-%m-%d") }, # Valid Visa card
    { primary_account_number: '4012888888881881', first_name: 'Dan', last_name: 'Marino', expiration_date: Time.strptime("2100-10-31", "%Y-%m-%d") }, # Invalid Visa card
])