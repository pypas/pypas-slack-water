require 'sidekiq/web'
Rails.application.routes.draw do
  root to: "home#index"
  post "/reminder", to: "slack#reminder"
  post "/interaction", to: "slack#interaction"

  mount Sidekiq::Web => "/sidekiq"
end