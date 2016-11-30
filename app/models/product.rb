class Product < ActiveRecord::Base
	belongs_to :shop
	belongs_to :order

    has_many :attachments
	# PRODUCT_ALL_CACHE = "product_all"
	# def search
	#     products = Rails.cache.exist?(PRODUCT_ALL_CACHE) ? Rails.cache.read(PRODUCT_ALL_CACHE) : Product.all
	#     Rails.cache.write(PRODUCT_ALL_CACHE, products)
	#     products
	# end

	def all_attachments
	    # task_attachments_all = []
	    task_attachments = self.attachments.order(created_at: :desc)
	    # task_attachments.each do |atta|
	    #   attach_h = {:attachment => atta}
	    #   task_attachments_all.push attach_h
	    # end
	 	
        task_attachments_all = [].tap do |x|
        	task_attachments.each { |atta| x << {attachment: atta} }
        end
	    task_attachments_all
  	end
end
