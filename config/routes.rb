Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :workouts, only: [:new, :show, :update]
  resources :workout_sets, only: [:update]
  resources :exercises, only: [:show]

  get '/users/:id/goals', to: 'users#goals', as: :user_goal
  get '/dashboard', to: 'users#dashboard', as: :dashboard

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
