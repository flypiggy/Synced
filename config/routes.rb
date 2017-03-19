Rails.application.routes.draw do
  root to: 'gmis#index'

  get 'login',  to: 'sessions#new'
  post 'login', to: 'sessions#create'

  constraints subdomain: 'gmis' do
    root 'gmis#index', as: :gmis
    get ':year', to: 'gmis#show', constraints: { year: /2017/ }
  end

  namespace :admin do
    resources :events, except: :show do
      scope module: 'events' do
        resources :guests, except: [:show, :new, :edit]
        resources :partner_categories, except: [:show, :new, :edit] do
          resources :partners, only: [:create, :update, :destroy]
        end
      end
    end
    resources :guests, except: :show
    resources :partners, except: :show
  end

  match 'vote_up/:id', to: 'votes#vote_up', via: [:post, :put, :patch]
end
