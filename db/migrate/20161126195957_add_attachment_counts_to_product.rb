class AddAttachmentCountsToProduct < ActiveRecord::Migration
  def change
  	add_column :products, :attachments_count ,:integer
  end
end
