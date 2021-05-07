Rails.application.routes.draw do
  get "/players", to: "players#index"
  get "/player/:code", to: "player#show"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
