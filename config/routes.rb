Rails.application.routes.draw do
  get 'players/index'
  get '/players', to: 'players#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
