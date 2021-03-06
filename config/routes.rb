Abe::Application.routes.draw do

  root :to => "welcome#index"

  scope "(:locale)" do

    match "/welcome"                        => "welcome#index"
    match "/login"                          => "welcome#login"
    match "/logout"                         => "welcome#logout"
    match "/signup"                         => "welcome#signup"
    match "/lost_password"                  => "welcome#lost_password"
    match "/lost_password_send"             => "welcome#lost_password_send"
    match "/lost_password_use/:token"       => "welcome#lost_password_use", :as => :lost_password_use
    match "lost_password_use_valid/:token"  => "welcome#lost_password_use_valid", :as => :lost_password_use_valid
    match "/signup_create"                  => "welcome#signup_create"
    match "/explore"                        => "categories#index"

    get "search/index"

    resources :categories, :except => :new

    resources :terms, :except => [ :index, :new ] do
      get :toggle_public
      collection do
        get :autocomplete_tag_name
      end
    end

    resources :comments, :except => [ :index, :show, :new, :edit, :update ] do
      get :toggle_approved
    end

    resources :tags, :except => [ :new, :create, :edit, :update, :destroy ]

    resources :users, :except => [ :new, :create, :destroy ]

  end

  match "/:locale" => "welcome#index"

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
