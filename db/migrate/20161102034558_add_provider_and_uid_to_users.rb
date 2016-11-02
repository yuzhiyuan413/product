class AddProviderAndUidToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :current_name, :string
    add_column :users, :profile_image, :string
  end
end
