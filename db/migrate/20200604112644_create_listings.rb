class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.string :name
      t.string :description
      t.integer :quantity_available
      t.references :user, null: false, foreign_key: true
      t.float :listing_price_pq

      t.timestamps
    end
  end
end
