SampleApp::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :customers
  resources :tasks
  resources :task_sets
  resources :feeder_tasks
  root 'static_pages#home'

  match '/signup',  to:'users#new',         via:'get'
  match '/signin',  to:'sessions#new',      via:'get'
  match '/signout', to:'sessions#destroy',  via:'delete'

  #root to:  'static_pages#home'
  
  match '/help',    to:'static_pages#help' ,    via: 'get'
  match '/about',   to:'static_pages#about' ,   via: 'get'
  match '/contact', to:'static_pages#contact' , via: 'get'

  match '/signup', to: 'users#new', via: 'get'

  match 'users/:id/toggle_admin', to: 'users#toggle_admin', via: 'get'
  match 'users/:id/toggle_senior', to: 'users#toggle_senior', via: 'get'

  match 'tasks/:id/complete', to: 'tasks#toggle_complete', via: 'get'
  match 'tasks/:id/do', to: 'tasks#toggle_do', via: 'get' 

  match '/accounts', to: 'customers#accounts', via: 'get'

  match '/my_tasks', to: 'tasks#my_tasks', via: 'get'
  match '/workspace', to: 'tasks#workspace', via: 'get'

  match '/team_customers', to: 'customers#team_customers', via: 'get'
  match '/team_users', to: 'users#team_users', via: 'get'
  match '/team_tasks', to: 'tasks#team_tasks', via: 'get'

  match '/my_tasksets', to: 'task_sets#my_tasksets', via: 'get'

  match '/choose_task_set/', to: 'tasks#choose_task_set', via: 'get'
  match '/apply_task_set/', to: 'tasks#apply_task_set', via: 'post'

  #get '/help',  to:'static_pages#help' 
  #get '/about', to:'static_pages#about'
  #get '/contact', to:'static_pages#contact'
  
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
