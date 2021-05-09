class AuthenticatedConstraint
  def matches?(request)
    request.session['user_id'].present?
  end
end

Rails
  .application
  .routes
  .draw do
    constraints AuthenticatedConstraint.new do
      root to: 'results#index', as: :user_root
    end

    root 'results#new'
    get '/auth/:provider/callback' => 'sessions#create'
    delete '/logout' => 'sessions#destroy'
    resources :results, only: %i[new create index show]
  end
