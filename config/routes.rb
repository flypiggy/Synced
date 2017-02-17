Rails.application.routes.draw do
  constraints subdomain: 'gmis' do
    root 'gmis#index', as: :gmis
    get ':year', to: 'gmis#show', constraints: { year: /2017/}
  end

  namespace :admin do
    resources :guest, except: :show
  end
end
