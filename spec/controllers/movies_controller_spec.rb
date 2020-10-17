require 'rails_helper'


RSpec.describe MoviesController, type: :controller do
  describe 'searching TMDb' do
    before :each do
      @fake_results = [double('movie1'), double('movie2')]
    end
    it 'calls the model method that performs TMDb search' do
      expect(Tmdb::Movie).to receive(:find).with('hardware').
        and_return(@fake_results)
      #post :search_tmdb, {:search_terms => 'hardware'}
      post :search_tmdb, params: {:search_terms => 'hardware'}
    end

    describe 'after valid search' do
      before :each do
        allow(Tmdb::Movie).to receive(:find).with('hardware').
        and_return(@fake_results)
        #post :search_tmdb, {:search_terms => 'hardware'}
        post :search_tmdb, params: {:search_terms => 'hardware'}
      end
      it 'selects the Search Results template for rendering' do
        expect(response).to render_template('search')
      end
      it 'makes the TMDb search results available to that template' do
        expect(assigns(:search)).to eq(@fake_results)
      end
    end
  end
  describe 'add movie' do
  before :each do
    @movie_object = {movie:{title:"inception",rating:"G",release_date:"2017-09-20",description: "so good"}}
  end
    describe "create a movie object in db" do
    it "saves the new movie in the database" do
    expect {
    post :create, :params => @movie_object
    }.to change(Movie,:count).by(1)
    end
    it "assigns the saved movie to @movie" do
    post :create, :params => @movie_object
    expect(assigns(:movie).title).to include("inception")
    end
    it "redirects to the home page" do
    post :create, :params => @movie_object
    expect(response).to redirect_to("/movies")
    end
  end
  before (:each) do
    @movie_object_attribute = {title:"inception",rating:"PG",release_date:"2019-09-23",description:"so good"}
    @movie_object_1 = FactoryGirl.create(:movie,@movie_object_attribute)
  end
  describe "GET #show" do
    it "assigns the requested movie to @movie" do
    
    get :show, params: {id: @movie_object_1.id}
    
    expect(assigns(:movie).title).to include("inception")
    end
    it "renders the :show template" do  
    get 'show', params: {id: @movie_object_1.id}
    expect(response).to render_template(:show)
      end
  end
end
end
