Cats99::Application.routes.draw do
  root to: 'cats#index'

  resources :users do
    resources :cats, only: [:create, :new, :update]
  end
  resource :session, only: [:new, :create, :destroy]

  resources :cats, except: [:create, :new, :update] do
    resources :cat_rental_requests, only: [:index]
  end

  resources :cat_rental_requests, only: [:create, :update, :destroy, :show, :edit, :new] do
    member do
      post 'approve'
      post 'deny'
    end
  end

  delete 'session/:id', to: 'sessions#kill_session', as: 'kill_session'
end
