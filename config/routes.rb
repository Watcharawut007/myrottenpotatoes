Myrottenpotatoes::Application.routes.draw do
  resources :movies do
    resources :reviews
  end
  root :to => redirect('/movies')

  get  'auth/:provider/callback' => 'sessions#create'
  post 'logout' => 'sessions#destroy'
  get  'auth/failure' => 'sessions#failure'
  get  'auth/twitter', :as => 'login'
  post 'search/:data' => 'movies#tmdb_search' , :as => 'search'
  
  post '/movies/search_tmdb'
end
