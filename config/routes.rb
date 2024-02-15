Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
  
  # Defines the root path route ("/")
  root "static_pages#top"
  
  get 'static_pages/top'
  get 'static_pages/terms'
  get 'static_pages/privacy_policy'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  resources :users, only: %i[new create]
  resources :password_resets, only: %i[new create edit update]
  resources :profiles, only: %i[edit update]
  resources :memos, only: %i[index new show create edit destroy]
  resources :bookmarks, only: %i[create destroy]
  resources :examples, only: %i[update]
  resources :pyramid_structures, only: %i[update]

  post 'explanations/element'
  post 'explanations/basis'

  post 'memos/:id', to: 'memos#update'
end
