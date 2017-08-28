Rails.application.routes.draw do
  root to: 'site#index'
  post '/', to: 'site#index'
  get '/features', to: 'site#features'
  get '/about', to: 'site#about'
  resources :clicks
  resources :links, only: [:index, :show, :create]

  get '/:code', to: 'links#visit'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
