Rails.application.routes.draw do
root :to => 'users#index'

#clean urls
get 'signup', to: 'users#new', as: 'signup'  
get 'login', to: 'sessions#new', as: 'login'
get 'logout', to: 'sessions#destroy', as: 'logout' 
 
#other

 resources :users do
    resources :photos
  end

 resources :sessions, :except => [:index, :show, :edit, :update ]
 resources :tags, :except => [:show, :edit, :update, :destroy]
 resources :favorites, :except => [:show, :edit, :update, :destroy]

end
