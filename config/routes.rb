Rails.application.routes.draw do
  resources :images, only: :show
  get "pages/show"
  get "tags/:name", to: "tags#show", name: /[-a-z0-9_+]*/, as: :tag
  get "/search/:year/:month",
    to: "search#index",
    year: /\d{4}/,
    month: /\d{2}/
  get "/search", to: "search#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index"
  get "/page/:slug", to: "pages#show", slug: /[-a-z0-9+]*/, as: :page

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
