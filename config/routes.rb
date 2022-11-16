Rails.application.routes.draw do
  get 'regards/regards'
  devise_for :users
  get 'users/regards', to: 'regards#index'

  root "questions#index"
  
  resources :questions do
    resources :answers do
      member do
        delete :delete_file
      end
    end
    member do
      put :best
      delete :delete_file
    end
  end

  resources :links, only: :destroy

end
