Myrottenpotatoes::Application.routes.draw do
  resources :movies do
    resources :reviews
    resources :avatar
  end
  root :to => redirect('/movies')

  get  'auth/:provider/callback' => 'sessions#create'
  post 'logout' => 'sessions#destroy'
  get  'auth/failure' => 'sessions#failure'
  get  'auth/twitter', :as => 'login'
  post '/movies/search_tmdb'
  post 'all_destroy' => 'movies#all_destroy' , :as => 'all_destroy'
  get 'create_all/:search_movie' => 'movies#create_from_search_movies' , :as => 'create_all_from_tmdb'
end
