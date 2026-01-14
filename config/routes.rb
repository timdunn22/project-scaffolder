Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  post '/auth/register', to: 'auth#register'
  post '/auth/login', to: 'auth#login'
  get '/auth/me', to: 'auth#me'

  resources :templates, only: [:index, :show, :create, :destroy]
  resources :projects, only: [:index] do
    post 'generate', on: :collection
  end
end
