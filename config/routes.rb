Rails.application.routes.draw do
  
  namespace :public do
    get 'searches/search'
  end
  # 利用者用
  
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  scope module: :public do
    
    root to: "homes#top"
    get "about" => "homes#about", as: "about"
    
    resources :articles do
      resources :comments, only:[:create, :destroy]
      resource :like, only:[:create, :destroy]
    end
    
    get "users/my_page/:id" => "users#show", as: "my_page"
    get "users/unsubscribe/:id" => "users#unsubscribe", as: "unsubscribe"
    resources :users, only: [:edit, :update, :show] do
      resource :relationship, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end
    
    resources :groups, except: [:destroy] do
      resource :group_user, onyl: [:create, :destroy]
    end
    
    get "searches/search" => "searches#search", as: "search"
    
  end
  
  

  
  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
