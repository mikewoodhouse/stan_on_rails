# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'report#home'

  get 'data/get/:dataset', to: 'report#get'

  get 'report/:key', to: 'report#fetch'
end
