class Shop < ActiveRecord::Base
	belongs_to :user
	has_many :products
	has_many :orders
end
