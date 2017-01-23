Rails.application.routes.draw do
  resources :plans
  resources :lessons
  resources :users

  root    'sessions#new'

  get     '/actualizarC', to: 'lessons#multiply'
  get     '/dynash', to: 'schedules#dynash'
  get     '/logout',  to: 'sessions#destroy'
  get     '/login',   to: 'sessions#new'
  
  get     '/lessons/p/:id',  to: 'lessons#index'
  get     '/lessons/p/',  to: 'lessons#index', as: 'lessons_paginated'
  get     '/cortesias/nueva',   to: 'courtesies#new'
  get     '/cortesias', to: 'courtesies#index'

  get     '/promo', to:   'events#promo'
  get     '/btce/automated', to: 'schedules#btce_automated'
  get     '/btce/:string', to: 'schedules#btce'
  get     '/btce/:string/:trans_id', to: 'schedules#btce'
  get     '/calendario',  to: 'schedules#new'
  get     '/cortesias/:id',     to: 'courtesies#show', as: 'courtesie'
  get     '/asistencia',  to: 'schedules#index'
  get     'signup',  to:  'users#new'
  get     'contactanos', to: 'static_pages#contact'
  get     'static_pages/home'
  get     'estadisticas', to: 'stats#index'
  get     'events', to: 'events#index'
  get     '/admin/estadisticas', to: 'stats#admin_index'
  get     '/admin/reminder', to: 'events#reminder'
  get     '/admin/estadisticas/tendencias', to: 'stats#trends'
  get     '/admin/estadisticas/tendencias/:user_id', to: 'stats#trends'
  get     'puntos', to:   'points#new'
  get     'mispuntos/:id', to:  'points#user_points', as: 'user_points'

  post    'puntos', to:   'points#create'
  post    '/cortesias/:id',       to:   'courtesies#check', as: 'courtesie_check'
  post    '/cortesias/status/:id',       to:   'courtesies#uncheck',    as: 'courtesie_uncheck'
  post    '/login',   to: 'sessions#create'
  post    '/cortesias/nueva',   to: 'courtesies#create'
  post    '/calendario',  to: 'schedules#appointment'
  post    '/asistencia',  to: 'schedules#index' 
  post    'referer/new', to: 'events#referer'
  
  delete  '/cortesias/:id',     to: 'courtesies#delete', as: 'courtesie_delete'
  delete  '/puntos/:id', to:   'points#destroy', as:   'punto_delete'
end
