class AddStatusToShops < ActiveRecord::Migration
  def change
  	add_column :shops, :status, :integer
  end
end
