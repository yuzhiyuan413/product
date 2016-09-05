module Pd
  class CommonAPI < ApplicationAPI
    resource :products do
			get "all" do
        Product.all
			end

      params do
        requires :id, type: Integer, desc: ' id.'
      end
      route_param :id do
        get do
          Product.find(params[:id])
        end
      end
      
  	end
  end

end