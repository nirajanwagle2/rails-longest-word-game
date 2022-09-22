Rails.application.routes.draw do
  get '/games/new', to: "games#new"
  post '/games/score', to: "games#score"

  root "games#new"
end
