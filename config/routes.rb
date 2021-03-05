Rails.application.routes.draw do
  match ':controller(/:action(/:id))', via: [ :get, :post, :patch ]
  root "results#index"

  get 'results/new'
  get 'results/create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
