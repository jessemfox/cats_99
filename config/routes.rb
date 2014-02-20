Cats99::Application.routes.draw do
  root to: 'cats#index'
  resources :cats do
    resources :cat_rental_requests, only: [:index]
  end

  resources :cat_rental_requests, only: [:create, :update, :destroy, :show, :edit, :new] do
    member do
      post 'approve'
      post 'deny'
    end
  end
end
