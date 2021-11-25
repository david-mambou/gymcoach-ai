Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'pages#home'

  resources :workouts, only: [:new, :create, :show, :edit, :update] do
    resources :workout_sets, only: [:update]
  end
  resources :exercises, only: [:show]
  # get 'charts/index'

  patch 'users/:id/routine/', to: 'users#routine', as: :user_routine
  get '/users/:id/goals', to: 'users#goals', as: :user_goals
  get '/dashboard', to: 'users#dashboard', as: :dashboard

  authenticate :user, ->(user) { user.admin? } do
    mount Blazer::Engine, at: "blazer"
  end

  resources :messages, only: [:create]
end
