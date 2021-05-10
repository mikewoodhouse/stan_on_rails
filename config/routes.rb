Rails.application.routes.draw do
  get "/season_records", to: "season_record#index"
  get "/players", to: "players#index"
  get "/player/:code", to: "player#show"
  get "/seasons", to: "season#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
