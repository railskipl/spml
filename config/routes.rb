require 'sidekiq/web'
Sndl::Application.routes.draw do
  resources :meter_reader_statuses

  resources :meter_statuses

  resources :dtc_staffs

  resources :mobile_devises


# ...
  mount Sidekiq::Web, at: '/sidekiq'

  get "homes/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'homes#index'

   resources :users 
 
  resources :sessions, :only => [:new,:create,:destroy,:edit]

  get 'dashboard' => 'users#dashboard', :as => 'user_root'

  get '/signup' =>'users#new'

  get '/signin' =>'sessions#new'

  get  '/users/:id/edit' => "users#edit" 

  post '/signout' =>'sessions#destroy'

  get '/user/:id/dtc_staffs', :to => "users#dtc"

  get '/dtc_staff/:dtc', :to => "dtc_staffs#dtc"
 
  get '/consumer/:consno', :to => "consumers#consumer"


  get '/readings/submit', :to => "readings#submit"

 resources :password_resets
 resources :staffs
 resources :readings

 resources :consumers do
    collection do 
      get 'add_csv'
      post 'import'
    end 
 end





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

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
