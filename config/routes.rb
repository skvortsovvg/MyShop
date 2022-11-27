Rails.application.routes.draw do
  get 'regards/regards'
  devise_for :users
  get 'users/regards', to: 'regards#index'

  root "questions#index"

  concern :commentable do
    post :comments, action: :new_comment
  end

  concern :delete_file do
    delete :delete_file
  end

  resources :questions, concerns: [:commentable, :delete_file], shallow: true do
    resources :answers, concerns: [:commentable, :delete_file] do
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
