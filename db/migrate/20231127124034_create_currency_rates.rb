class CreateCurrencyRates < ActiveRecord::Migration[7.0]
  def change
    create_table :currency_rates do |t|
      t.string :currency
      t.integer :nominal
      t.string :name
      t.decimal :value
      t.date :date

      t.timestamps
    end
  end
end
