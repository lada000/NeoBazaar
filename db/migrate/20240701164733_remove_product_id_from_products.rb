class RemoveProductIdFromProducts < ActiveRecord::Migration[7.1]
  def change
    remove_index :products, :product_id if index_exists?(:products, :product_id)
    remove_column :products, :product_id, :integer
  end
end
