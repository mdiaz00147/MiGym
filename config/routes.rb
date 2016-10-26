Rails.application.routes.draw do
  resources :plans
  resources :lessons
  resources :users
  get     '/actualizarC', to: 'lessons#multiply'
  get     '/dynash', to: 'schedules#dynash'
  get     '/logout',  to: 'sessions#destroy'
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  get     '/lessons/p/:id',  to: 'lessons#index'
  get     '/lessons/p/',  to: 'lessons#index', as: 'lessons_paginated'
  get     '/cortesias/nueva',   to: 'courtesies#new'
  post    '/cortesias/nueva',   to: 'courtesies#create'
  get     '/cortesias/:id',     to: 'courtesies#show', as: 'courtesie'
  delete  '/cortesias/:id',     to: 'courtesies#delete', as: 'courtesie_delete'

  get     '/cortesias', to: 'courtesies#index'



  get     '/btce/:string', to: 'schedules#btce'



  get     '/calendario',  to: 'schedules#new'
  get     '/calendario2', to: 'schedules#new2'
  post    '/calendario2',  to: 'schedules#appointment'
  post    '/calendario',  to: 'schedules#appointment'
  get     '/asistencia',  to: 'schedules#index'
  post    '/asistencia',  to: 'schedules#index'

  get     'signup',  to:  'users#new'
  get     'contactanos', to: 'static_pages#contact'
  get     'static_pages/home'
  get     'estadisticas', to: 'stats#index'
  post    'referer/new', to: 'events#referer'
  get     'events', to: 'events#index'
  get     '/admin/estadisticas', to: 'stats#admin_index'
  get     '/admin/reminder', to: 'events#reminder'
  get     '/admin/estadisticas/tendencias', to: 'stats#trends'
  get     '/admin/estadisticas/tendencias/:user_id', to: 'stats#trends'

  root    'sessions#new'
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
