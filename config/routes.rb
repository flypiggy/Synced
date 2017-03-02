Rails.application.routes.draw do
  root controller: 'static', action: '/'

  get 'login',  to: 'sessions#new'
  post 'login', to: 'sessions#create'

  constraints subdomain: 'gmis' do
    root 'gmis#index', as: :gmis
    get ':year', to: 'gmis#show', constraints: { year: /2017/ }
  end

  namespace :admin do
    resources :guests, except: :show do
      scope module: 'guests' do
        resources :avatars, only: [:create, :destroy]
      end
    end
  end

  match 'vote_up/:id', to: 'votes#vote_up', via: [:post, :put, :patch]
end
