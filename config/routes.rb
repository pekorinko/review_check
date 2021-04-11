Rails.application.routes.draw { resources :results, only: %i[new create index] }
