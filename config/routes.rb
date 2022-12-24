Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  
  scope "api/v1" do
    resources :users
    resources :tests
    resources :contacts
    resources :messages
    
    post '/auth/login', to: 'authentication#login'
  end
  get '/*a', to: 'application#not_found'
end
