class Product < ActiveRecord::Base
	belongs_to :shop
	belongs_to :order

	# PRODUCT_ALL_CACHE = "product_all"
	# def search
	#     products = Rails.cache.exist?(PRODUCT_ALL_CACHE) ? Rails.cache.read(PRODUCT_ALL_CACHE) : Product.all
	#     Rails.cache.write(PRODUCT_ALL_CACHE, products)
	#     products
	# end

end
