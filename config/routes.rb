Rails.application.routes.draw do
  root to: "home#index"
  post "/reminder", to: "slack#reminder"
end