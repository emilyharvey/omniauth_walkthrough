OmniauthTutorial::Application.routes.draw do
  get "password_resets/new"

  resources :authentications, :identities, :users, :masters, :password_resets
  
  match "/auth/failure", :to => "pages#error"

  # OmniAuth strategies require a callback
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  
  root :to => 'pages#home'
end
