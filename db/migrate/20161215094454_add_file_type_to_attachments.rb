class AddFileTypeToAttachments < ActiveRecord::Migration
  def change
  	add_column :attachments, :file_type, :string
  end
end
