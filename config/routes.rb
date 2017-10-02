Rails.application.routes.draw do
  root to: 'kittens#index'
  
  resources :kittens

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
