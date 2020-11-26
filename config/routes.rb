Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'users'
      resources :gifts
      resources :schools do
        patch 'address', on: :member
      end

      resources :recipients do
        patch 'address', on: :member
      end

      resources :orders, only: %i[create update] do
        member do
          patch 'cancel'
          patch 'ship'
        end
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
