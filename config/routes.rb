Rails.application.routes.draw do
  root to: 'site#index'
  resources :links, only: [:index, :show, :create] do
    member do
      get :clicks
      get :stat
    end
  end

  get '/:code', to: 'links#visit'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
