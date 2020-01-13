Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :albums do
    resources :songs
  end
  resources :artists
  resources :home, only: [:index]
  root to: 'home#index'
end
