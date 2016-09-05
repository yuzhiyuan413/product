module Pd
  class CommonAPI < ApplicationAPI
    resource :products do
				get "all" do
          Product.all
				end

        get "get_single" do
          Product.where(id: params[:id])
        end
  	end
  end

end