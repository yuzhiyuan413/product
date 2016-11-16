class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.string :content
      t.integer :product_id
      t.integer :shop_id
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
