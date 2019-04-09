Rails.application.routes.draw do
  get 'teachers/show'
  get 'teachers/new'
  get 'teachers/edit'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :professionals, except: :destroy do # only: [:index, :show, :new, :create, :edit, :update]
    resources :lectures, only: [:index, :show, :edit, :update] do
      resources :comments, only: [:new, :create]
    end
  end

  resources :teachers, only: [:show, :new, :create, :edit, :update] do
    resources :lectures, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
    end
    resources :class_rooms
  end
end
