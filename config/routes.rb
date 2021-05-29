Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "season#index"

  get "/players", to: "players#appearances"
  get "/players/appearances", to: "players#appearances"
  get "/players/captains", to: "players#captains"
  get "/players/:code", to: "players#show"

  get "/season_records", to: "season_record#index"

  get "/seasons", to: "season#index"
  get "season/averages/:year", to: "season#averages"

  get "batting/hundred_plus"
  get "batting/most_runs"
  get "batting/averages"

  get "bowling/averages"
  get "bowling/wickets"
  get "bowling/five_for"
end
