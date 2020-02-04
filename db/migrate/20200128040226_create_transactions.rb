class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.json 'spreedly_transaction'
      t.timestamps
    end
  end
end
