Rails.application.routes.draw do
  resources :attachments
  resources :comments
  resources :shops
  use_doorkeeper
  resources :products
  mount ApplicationAPI, at: 'api'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'products#index'
  
  # devise_for :users, controllers: {  }
  devise_for :user, controllers: { sessions: "users/sessions",
                                   registrations: "users/registrations",
                                   invitations: "users/invitations",
                                   confirmations: "users/confirmations",
                                   omniauth_callbacks: 'users/omniauth_callbacks',
                                   passwords: "users/passwords"
                                  } 
  devise_scope :user do
    get 'users/new_by_mobile', :to => 'users/registrations#new_by_mobile'
    post 'users/send_sms', :to => 'users/registrations#send_sms'
    post 'users/sms_verify', :to => 'users/registrations#sms_verify'
    get 'users/bind', :to => 'users/registrations#bind'
    post 'users/create_bind', :to => 'users/registrations#create_bind'
  end

  resources :users do 
    resources :orders
  end

  resources :orders
  resources :shops

  # match '/users/auth/:provider/callback' => 'users/omniauth_callbacks#callback', via: [:get, :post]
  match '/user/auth/wechat' => 'users/omniauth_callbacks#passthru', via: [:get, :post]
  match '/user/auth/wechat/callback' => 'users/omniauth_callbacks#wechat', via: [:get, :post]

  # devise_for :users, controllers: {
  #   omniauth_callbacks: :authentications
  # }
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
