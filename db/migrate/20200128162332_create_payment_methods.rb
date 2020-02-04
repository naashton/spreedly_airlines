class CreatePaymentMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_methods do |t|
      t.string :spreedly_payment_token
      t.integer :primary_account_number
      t.string :first_name
      t.string :last_name
      t.string :expiration_month
      t.string :expiration_year
      t.timestamps
    end
  end
end
