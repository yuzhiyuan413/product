class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
    	t.string :file_name
      t.string :file_name_uid
      t.integer :filesize
      t.integer :version
      t.integer :product_id
      t.integer :comment_id
      t.integer :shop_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
