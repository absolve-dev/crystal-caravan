Rails.application.routes.draw do
  
  devise_for :admins, controllers: { registrations: "admins/registrations" }
  get '/users/my_account' => 'users#my_account', as: :my_account  
  devise_for :users
  
  namespace :dashboard do
    root 'panel#index'
    resources :games, constraints: { format: 'html' }
    resources :categories, constraints: { format: 'html' }
    resources :products, constraints: { format: 'html' }
    resources :catalogs, constraints: { format: 'html' }
    get 'catalogs/:id/sync' => 'catalogs#sync', as: :catalog_sync
    get 'catalogs/:id/wipe' => 'catalogs#wipe', as: :catalog_wipe
    get 'catalogs/set/:set_id' => 'catalogs#set', as: :catalog_set
    get 'catalogs/card/:card_id' => 'catalogs#card', as: :catalog_card
    resources :orders
    get 'orders/:id/fulfill' => 'orders#fulfill', as: :order_fulfill
    get 'orders/:id/cancel' => 'orders#cancel', as: :order_cancel
    resources :shipping_services
    delete 'shipping_services/shipping_method_destroy/:method_id' => 'shipping_services#destroy_shipping_method', as: :shipping_method_delete
    resources :discount_codes
  end
  
  resources :games, only: [:index, :show]
  resources :categories, only: [:show]
  resources :products, only: [:show]
  resources :carts, only: [:update]
  get 'cart' => 'carts#cart', as: :show_cart
  resources :line_items, only: [:create, :destroy]
  get 'orders/:id/cancel' => 'orders#cancel', as: :order_cancel
  post 'orders/bill_info' => 'orders#bill_info_update', as: :order_bill_info_update
  get 'orders/bill_info' => 'orders#bill_info_form', as: :order_bill_info_form
  post 'orders/ship_info' => 'orders#ship_info_update', as: :order_ship_info_update
  get 'orders/ship_info' => 'orders#ship_info_form', as: :order_ship_info_form
  post 'orders/ship_options' => 'orders#ship_options_update', as: :order_ship_options_update
  get 'orders/ship_options' => 'orders#ship_options_form', as: :order_ship_options_form
  post 'orders/payment' => 'orders#payment_update', as: :order_payment_update
  get 'orders/payment' => 'orders#payment_form', as: :order_payment_form
  post 'orders/checkout' => 'orders#checkout_update', as: :order_checkout_update
  get 'orders/checkout' => 'orders#checkout_form', as: :order_checkout_form
  resources :orders, only: [:show, :new]
  
  root 'static_pages#home'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  
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
