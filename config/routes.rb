Rails.application.routes.draw do
  devise_for :users
  match 'posts', to: 'posts#update', via: [:options]
  resources :posts
  match 'vote', to: 'posts#create_votes', via: [:post]
  root to: "posts#index"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
