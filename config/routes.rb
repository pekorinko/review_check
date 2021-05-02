Rails
  .application
  .routes
  .draw do
    root 'results#new'
    get '/auth/:provider/callback' => 'sessions#create'
    delete '/logout' => 'sessions#destroy'
    resources :results, only: %i[new create index show]
  end
