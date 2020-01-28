class CreateAircrafts < ActiveRecord::Migration[6.0]
  def change
    create_table :aircrafts do |t|
      t.string :aircraft_no
      t.string :manufacturer
      t.integer :capacity
      t.timestamps
    end
  end
end
