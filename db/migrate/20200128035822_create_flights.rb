class CreateFlights < ActiveRecord::Migration[6.0]
  def change
    create_table :flights do |t|
      t.string :flight_no
      t.string :origin
      t.string :destination
      t.timestamp :departure
      t.timestamp :arrival
      t.integer :price
      t.timestamps
    end
  end
end
