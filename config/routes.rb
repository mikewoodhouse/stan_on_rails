Rails.application.routes.draw do
  get "/players", to: "players#index"
  get "/players/appearances", to: "players#appearances"
  get "/players/:code", to: "players#show"

  get "/season_records", to: "season_record#index"

  get "/seasons", to: "season#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
