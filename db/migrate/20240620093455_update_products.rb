class UpdateProducts < ActiveRecord::Migration[7.1]
  def change
    change_table :products do |t|
      t.integer :product_id, null: false
      t.date :date, null: false, default: -> { 'CURRENT_DATE' }
      t.string :status, null: false, default: 'Draft'
      t.string :currency, null: false
      t.boolean :allow_customers_to_pay_what_they_want, default: false
      t.integer :quantity_for_sale
      t.string :delivery_time, null: false
    end

    add_index :products, :product_id, unique: true
  end
end
