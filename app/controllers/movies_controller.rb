class MoviesController < ApplicationController
  skip_before_action :authenticate!, only: [ :show, :index ]
  
  def index
    @movies = Movie.all.order('title')
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    render(:partial => 'movie', :object => @movie) if request.xhr?
    # will render app/views/movies/show.html.haml by default
  end

  def new
    @movie = Movie.new
  end

  def create
    params.require(:movie)
    permitted = params[:movie].permit(:title,:rating,:release_date,:description)
    @movie = Movie.create!(permitted)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movie_path(@movie)
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    permitted = params[:movie].permit(:title,:rating,:release_date,:description)
    @movie.update_attributes!(permitted)

    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  def movies_with_filters
    @movies = Movie.with_good_reviews(params[:threshold])
    @movies = @movies.for_kids          if params[:for_kids]
    @movies = @movies.with_many_fans    if params[:with_many_fans]
    @movies = @movies.recently_reviewed if params[:recently_reviewed]
  end

  def tmdb_search
    @search = Tmdb::Search.new
    @search.resource('movie') # determines type of resource
    @search.query('batman') # the query to search against
    @search.fetch # makes request
  end
end
