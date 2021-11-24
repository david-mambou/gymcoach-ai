Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :workouts, only: [:new, :create, :show, :edit, :update] do
    resources :workout_sets, only: [:update]
  end
  resources :exercises, only: [:show]

  patch 'users/:id/routine/', to: 'users#routine', as: :user_routine
  get '/users/:id/goals', to: 'users#goals', as: :user_goals
  get '/dashboard', to: 'users#dashboard', as: :dashboard

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
