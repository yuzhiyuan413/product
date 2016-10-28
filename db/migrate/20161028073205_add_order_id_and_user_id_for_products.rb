class AddOrderIdAndUserIdForProducts < ActiveRecord::Migration
  def change
  	add_column :products, :order_id, :integer
  	add_column :products, :user_id, :integer
  end
end
