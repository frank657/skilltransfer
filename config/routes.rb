Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :professionals, except: :destroy do # only: [:index, :show, :new, :create, :edit, :update]
    resources :lectures, only: [:new, :create, :index, :show, :edit, :update] do
      resources :comments, only: [:new, :create]
    end
  end

  resources :teachers, only: [:new, :create, :edit, :update] do
    resources :lectures, only: [:index, :show] do
      resources :comments, only: [:new, :create]
    end
    resources :class_rooms
  end
end
