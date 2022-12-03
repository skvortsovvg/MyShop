Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }
  
  root "questions#index"

  get 'regards/regards'
  get 'users/regards', to: 'regards#index'

  concern :commentable do
    post :comments, action: :new_comment
  end

  concern :delete_file do
    delete :delete_file
  end

  resources :questions, concerns: %i[commentable delete_file], shallow: true do
    resources :answers, concerns: %i[commentable delete_file] do
      member do
        put :like
      end
    end
    member do
      put :best
    end
  end

  resources :links, only: :destroy

  mount ActionCable.server => '/cable'
end
