Rails.application.routes.draw do
  get '/oturum_ac', to: 'sessions#new', as: :login
  delete '/oturup_kapat', to: 'sessions#destroy', as: :logout
  resource :session, only: :create

  resources :forums, only: [:index, :show], path: 'forumlar' do
    resources :topics, only: [:new, :create], path: 'konular', path_names: {new: 'yeni'}
  end

  resources :topics, expect: [:index, :new, :create], path: 'konular', path_names: {edit: 'duzenle'}

  resources :users, only: [:create, :update, :destroy]
  get '/kaydol', to: 'users#new', as: :register
  get '/:id', to: 'users#show', as: :profile
  get '/:id/duzenle', to: 'users#edit', as: :edit_profile

  root 'forums#index'
  
  
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