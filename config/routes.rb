Rails.application.routes.draw do
  root 'pages#home'    
  get '/home' => 'pages#home'

#  resources :recipes #does what the code block below does.
################################################################################  
#  get '/recipes', to: 'recipes#index'
#  get '/recipes/new', to: 'recipes#new', as: 'new_recipe'
#  post '/recipes', to: 'recipes#create'
#  get '/recipes/:id/edit', to: 'recipes#edit', as: 'edit_recipe'
#  patch '/recipes/:id', to: 'recipes#update'
#  get '/recipes/:id', to: 'recipes#show', as: 'recipe'
#  delete '/recipes/:id', to: 'recipes#destroy'
################################################################################
  
  resources :recipes do
    member do
      post 'like'
    end
  end
  
  resources :chefs, except: [:new]
  get '/register' => 'chefs#new'
  
  get '/login' => 'logins#new'
  post '/login' => 'logins#create'
  get '/logout' => 'logins#destroy'
  
end
