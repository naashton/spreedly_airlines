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