Rails.application.routes.draw do
  root to: 'site#index'
  post '/', to: 'site#index'

  get '/features', to: 'site#features'
  get '/about', to: 'site#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
