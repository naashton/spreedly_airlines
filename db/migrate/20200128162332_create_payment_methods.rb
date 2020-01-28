class CreatePaymentMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_methods do |t|
      t.integer :primary_account_number
      t.string :first_name
      t.string :last_name
      t.timestamp :expiration_date
      t.timestamps
    end
  end
end
