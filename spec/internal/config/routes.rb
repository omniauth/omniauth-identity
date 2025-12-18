# frozen_string_literal: true

Rails.application.routes.draw do
  # Root route
  root to: proc { [200, {"Content-Type" => "text/plain"}, ["Rails Identity Test App"]] }

  # OmniAuth callback routes
  get "/auth/:provider/callback", to: "sessions#create"
  post "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure", to: "sessions#failure"
end
