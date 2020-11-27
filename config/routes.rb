Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'strava#index'
  get '/strava/code', to: 'strava#code'
  # get '/strava/:id', to: 'strava#show', as: 'strava'
  resources :stravas, controller: 'strava'

end
