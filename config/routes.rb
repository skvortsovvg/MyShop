Rails.application.routes.draw do
  devise_for :users
  root "questions#index"

  resources :questions do
    resources :answers
      member do
        put :best
      end
  end
end
