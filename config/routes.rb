TradeLabor::Application.routes.draw do
  resources :search_suggestions


  resources :skills do
    collection do
      get 'autocomplete' , :action => 'autocomplete'
    end  
  end  


  get "schedule/new"

  get "photo/new"

  get "photo/create"

  get "photo/show"

  devise_for :users, :controllers => {:registrations => "newregistrations"}
  resources :users,only:[:show] do
    resources :photos, :except => [:update, :edit] do
      member do
        post 'set_as_profile_photo' ,:action => 'set_as_profile_photo'
      end  
    end  
    resource :schedule
    member do
      post 'rate' , :action => 'rate'
    end  
    collection do
      put 'post_feedback/:business_id' , :action => 'post_feedback' , :as => 'post_feedback'
    end  
  end
  resources :zipcodes
  root :to => "welcome#index"

  get "welcome/index"

  get "new_payment_detail" => "welcome#new_payment_detail"

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
