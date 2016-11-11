class Order < ActiveRecord::Base
	belongs_to :user
	belongs_to :shop
	has_many :products
	scope :by_user_id, -> user_id { where(user_id: user_id) } 
end
