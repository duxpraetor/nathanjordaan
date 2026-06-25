Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  mount RailsIcons::Engine, at: '/rails_icons'

  resources :contacts do
    collection do
      get :thank_you
    end
  end

  get "cv/index", to: "cvs#index"
  get "cv/pdf", to: "cvs#pdf", as: :cv_pdf

  resource :cv, only: [:show, :edit, :update] do
    resources :sections, only: [:new, :create]
  end
  resources :sections, only: [:edit, :update, :destroy] do
    resources :entries, only: [:new, :create]
  end
  resources :entries, only: [:edit, :update, :destroy] do
    resources :bullets, only: [:new, :create]
  end
  resources :bullets, only: [:edit, :update, :destroy]

  get "home/index"

  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"
end
