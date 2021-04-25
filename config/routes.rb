Rails
  .application
  .routes
  .draw do
    root 'results#new'
    get '/auth/:provider/callback' => 'sessions#create'
    resources :results, only: %i[new create index show]
  end
