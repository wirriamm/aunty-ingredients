class AddDeleteStatusToListings < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :delete_status, :boolean, default: false
  end
end
