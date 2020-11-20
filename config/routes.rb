Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :schools do
        patch 'address', on: :member
      end

      resources :recipients do
        patch 'address', on: :member
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
