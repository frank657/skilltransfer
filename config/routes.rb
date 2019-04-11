Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  get '/professional_dashboard', to: 'users#professional_dashboard', as: 'p_dashboard'
  root to: 'pages#landing'
  get 'teacher_info', to: 'pages#teacher_info', as: :teacher_info
  get 'professional_info', to: 'pages#professional_info', as: :professional_info
  get '/tagged', to: "professionals#tagged", as: :tagged

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :professionals, except: :destroy do # only: [:index, :show, :new, :create, :edit, :update]
    resources :lectures, only: [:new, :create, :index, :show, :edit, :update] do
      resources :comments, only: [:new, :create]
    end
  end

  resources :teachers, only: [:new, :create, :edit, :update] do
    resources :lectures, only: [:index] do
      resources :comments, only: [:new, :create]
    end
    resources :class_rooms, only: [:new, :create]
  end

  resources :lectures, only: [:show]
  resources :videotokens, only: [:create]
end
