class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
    	t.string :provider
      t.string :uid
      t.string :access_token
      t.string :user_id
      t.timestamps null: false
    end
  end
end
