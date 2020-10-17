class MoviesController < ApplicationController
  skip_before_action :authenticate!, only: [ :show, :index ,:search_tmdb ,:show_tmdb]
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
      if set_current_user
        @movie = Movie.new
      else
        flash[:warning] = "Please log in before create action"
        redirect_to movies_path
      end
    end

    def create
      params.require(:movie)
      permitted = params[:movie].permit(:title,:rating,:release_date,:description)
      @movie = Movie.create!(permitted)
      @movie.avatar.attach(params[:avatar])
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_path
    end

    def edit
      if set_current_user
        @movie = Movie.find params[:id]
      else
        flash[:warning] = "Please log in before edit action"
        redirect_to movies_path
      end
    end

    def update
      @movie = Movie.find params[:id]
      permitted = params[:movie].permit(:title,:rating,:release_date,:description)
      @movie.update_attributes!(permitted)

      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to movie_path(@movie)
    end

    def destroy
      if set_current_user
        @movie = Movie.find(params[:id])
        @movie.destroy
        flash[:notice] = "Movie '#{@movie.title}' deleted."
        redirect_to movies_path
      else
        flash[:warning] = "Please log in before destroy action"
        redirect_to movies_path
      end
    end
    def search_tmdb
      @search_params = params[:search_terms]
      @search_params = " " if @search_params  == ""
      @search = Tmdb::Movie.find(@search_params)
      @search.each do |movie|
        if Movie.exists?(:title => movie.title,:description => movie.overview) == false
          permitted = {:title => movie.title,:rating =>"G" ,:release_date =>movie.release_date,:description => movie.overview}
          @movie = Movie.create!(permitted)
        end
      end

      #@search = Movie.find_in_tmdb(@search_params)
      
      if @search != []
        render "search"
      else
        flash[:warning] = "'#{params[:search_terms]}' was not found in TMDb."
        redirect_to movies_path
      end
    end
    def show_tmdb
      id = params[:id] # retrieve movie ID from URI route
      @search = Tmdb::Movie.lists(id)
      #render(:partial => 'tmdbmovie', :object => @movie) if request.xhr?
      render "show_tmdb"
    end

  end
