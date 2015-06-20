Rails.application.routes.draw do

  resources :users

  #get 'home/index'
  root "home#index"
  get 'home' => 'home#index'
  get 'categorized' => 'home#categorizedAhadith'
  get 'unCategorized' => 'home#unCategorizedAhadith'
  match ':controller(/:action(/:topicName))', :via => :get
  get '/home/category/:number' => 'home#category'
  get 'advanceSearch' => 'home#advanceSearch'
  get 'login'   => 'sessions#new'
  post'login'   => 'sessions#create'
  get 'signuplogin' => 'sessions#create1'
  get 'logout'  => 'sessions#destroy'

  get 'signup' => 'users#new'
  get 'profile' => 'users#edit_profile'
#  get 'messages' => 'users#messaging'
  get 'conversation' => 'conversations#index'
  get 'addcollection' => 'collection#add_collection'
  get 'removecollection/:id' => 'collection#remove_collection'
  get 'addcategory' => 'categorization#add_category'
  get 'favouritecollection' => 'collection#show_collection'
  get 'removeallcollection' => 'collection#remove_all_collection'
  get 'sendmessage' => 'conversations#send_message'
  get 'createconversation' => 'conversations#create_conversation'
  get 'adminView' => 'home#adminView'
  get 'deleteScholar' => 'users#destroy'
  get 'simplesearch' => 'home#category'
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
