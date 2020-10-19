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
  before (:each) do
    @Antman_attribute = {:title => "Antman",:rating => "PG",:release_date => "2019-09-23"}
  end
  describe 'add movie' do
    describe "create a movie object in db" do
    it "saves the new movie in the database" do
    expect {
    post :create, params: {
      movie: @Antman_attribute
              } 
    }.to change(Movie,:count).by(1)
    end
    it "assigns the saved movie to @movie" do
    post :create, params:  {
      movie: @Antman_attribute} 
    
    expect(assigns(:movie).title).to include("Antman")
    end
    it "redirects to the home page" do
    post :create, params: {:movie => {
      movie: @Antman_attribute
              } 
    }
    expect(response).to redirect_to("/movies")
    end
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
  
  before (:each) do
    @movie_object_attribute = {:title => "inception",:rating => "PG",:release_date => "2019-09-23"}
    @movie_object_1 = FactoryBot.create(:movie,@movie_object_attribute)
  end
  describe "DELETE #destroy" do
    it "deletes the movie" do
      expect{
        delete :destroy, params: {id: @movie_object_1.id}
      }.to change(Movie,:count).by(-1)
    end
    it "redirects to the main page " do
      delete :destroy, params: {id: @movie_object_1.id}
      expect(response).to redirect_to(:action => 'index') 
    end
  end
end
end
