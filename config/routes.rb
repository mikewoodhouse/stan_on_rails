Rails.application.routes.draw do
  root "season#index"

  get "/players", to: "players#appearances"
  get "/players/appearances", to: "players#appearances"
  get "/players/:code", to: "players#show"

  get "/season_records", to: "season_record#index"

  get "/seasons", to: "season#index"

  get "batting/hundred_plus"
  get "batting/most_runs"
  get "batting/averages"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
