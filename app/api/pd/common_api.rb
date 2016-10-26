module Pd
  class CommonAPI < ApplicationAPI
    #产品资源
    resource :products do
      desc "Return all product."
      get do
        Product.all
      end
    
      desc "Return a product."  
        params do
          requires :id, type: Integer, desc: ' id.'
        end
        # route_param :id do
          get ':id' do
            # guard!
            Product.find(params[:id])
          end
        # end
      
      desc "Create a product."  
      post do
        guard!
        params.delete("access_token")
        Product.create!(params.to_h) ? {msg: 'ok'} : {msg: 'fail'}
      end
      
      desc "Update a product."  
      params do
        requires :id, type: Integer, desc: ' id.'
        requires :name, type: String, desc: ' name.'
        requires :sprice, type: Float, desc: ' sprice.'
        requires :desc, type: String, desc: ' desc.'
      end
      put ':id' do
        guard!
        params.delete("access_token")
        product = Product.find(params[:id])
        product.update(params.to_h) ? {msg: 'ok'} : {msg: 'fail'}
      end

      desc "Delete a product."
      params do
        requires :id, type: Integer, desc: " id."
      end
      delete ':id' do
        guard!
        product = Product.find(params[:id])
        product.destroy ? {msg: 'ok'} : {msg: 'fail'}
      end
    end
    #用户资源
    resource :users do
      params do
        requires :id, type: Integer, desc: ' id.'
      end
      get ':id' do
        resouce :products do
          get do
            #all products by user
          end
        end
      end 
    end

    # get 'products' do
    #   {
    #     "datas" : [ 产品1, 产品2, 产品3, ...],
    #     "single_products_url" : "/products/:id",
    #     "get_access_token_url" : "/oauth/token",
    #      ... 
    #   }
    # end

  end
end
