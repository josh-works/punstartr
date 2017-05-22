Rails.application.routes.draw do
  root 'home#index'

  get '/signup',    to: "users#new"
  get '/login',     to: "sessions#new"
  get '/logout',    to: "sessions#destroy"

  resources :users, only: [:new, :create, :index]

  namespace :users do
    get '/:user_id/projects', to: "projects#index"
  end
  resources :categories, only: [:index, :show]
  resources :rewards, only: [:index, :create, :new]
  resources :projects, only: [:index, :show, :edit]
  resources :sessions, only: [:new, :create, :destroy]
end
