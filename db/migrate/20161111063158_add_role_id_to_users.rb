class AddRoleIdToUsers < ActiveRecord::Migration
  def change
  	add_columns :users, :role_id, :integer
  end
end
