Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users do
    resources :tweets
    resources :photos
  end

  post 'users/:user_id/tweets/:id/like', to: 'tweets#like'
  post '/login', to: 'users#login'
  
end
