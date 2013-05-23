TextSupport::Application.routes.draw do

  resources :beta_emails

  #devise_for :users
  devise_for :members, :controllers => {:sessions => "sessions", :registrations => "registrations"}
  devise_scope :member do
    get "update_device_token", :to => "registrations#update_device_token"
  end
  match '/login', :to => 'pages#login'
  get '/chatusers/chat_random_user' => "chatusers#chat_random_user", :as => "chat_random_user"
  get '/chatusers/get_nick_name' => 'chatusers#get_nick_name'
  get '/mains/main' => "mains#main", :as => "mains_main"

  match '/about' => 'pages#about', :as => "about"
  match '/info' => 'pages#info', :as => "info"
  match '/privacy' => 'pages#privacy', :as => "privacy"
  match '/terms' => 'pages#terms', :as => "terms"
  match '/contacts' => 'pages#contacts', :as => "contacts"
#  match '/user_list' => 'pages#user_list', :as => "user_list"
  match '/one_minute' => 'pages#one_minute', :as => "one_minute"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'mains#main'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
