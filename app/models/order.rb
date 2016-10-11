class Order < ActiveRecord::Base
	belongs_to :user
	scope :by_user_id, -> user_id { where(user_id: user_id) } 
end
