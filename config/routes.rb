Rails.application.routes.draw do
  resources :enrollments
  devise_for :users
  resources :hostels do
    get :created, :unapproved, on: :collection
    member do
      get :approve
      get :unapprove
    end
    resources :rooms
    resources :enrollments, only: [:new, :create]
  end
  resources :users, only: [:index, :edit, :show, :update]
  get 'home/index'
  get 'activity', to: 'home#activity'
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
