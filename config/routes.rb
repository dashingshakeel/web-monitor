Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/new'
  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"
  root 'welcome#index'
  resources :users
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :supervisors do

    resources :services do
      get '/logs' => 'logs#index'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
