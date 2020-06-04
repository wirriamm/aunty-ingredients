class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :payment, null: false, foreign_key: true
      t.integer :quantity_ordered
      t.boolean :completed, default: false
      t.float :order_price_pq

      t.timestamps
    end
  end
end
