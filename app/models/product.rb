class Product < ActiveRecord::Base
	belongs_to :shop
	belongs_to :order

	PRODUCT_ALL = "product_all"
	# def search
	#     products = Rails.cache.exist?(PRODUCT_ALL) ? Rails.cache.read(PRODUCT_ALL) : Product.all
	#     Rails.cache.write(cache_key, products)
	#     products
	# end

end
