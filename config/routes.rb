Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [:index, :new, :create, :show]
  resources :subs, except: [:destroy]
  resources :posts, only: [:edit, :update, :new, :create, :show]
  resource :sessions, only: [:new, :create, :destroy]
end
