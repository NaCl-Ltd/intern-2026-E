Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root   "static_pages#home"
  get    "/help",    to: "static_pages#help"
  get    "/about",   to: "static_pages#about"
  get    "/contact", to: "static_pages#contact"
  get    "/signup",  to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :users do
    member do
      get :following
      get :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :update, :destroy, :edit] #pin機能実装のためにアップデートを追加
  resources :microposts, only: [] do # micropostsのルートはここで作成しないためonly: []にしている。
    resource :like, only: [:create, :destroy]
  end
  resources :relationships,       only: [:create, :destroy]
  get '/microposts', to: 'static_pages#home'
  
  patch '/microposts/:id/pin', to: 'microposts#pin', as: :pin_micropost
  patch '/microposts/:id/bookmark', to: 'microposts#bookmark', as: :bookmark_micropost
end
