class ApplicationController < ActionController::Base
  before_action :set_current_user , :authenticate! , :set_config
    protected # prevents method from being invoked by a route
    def set_current_user
      # we exploit the fact that the below query may return nil
      @current_user ||= Moviegoer.find_by(:id => session[:user_id])
    end
    def authenticate!
      unless @current_user
          redirect_to OmniAuth.login_path(:provider)
      end
    end

    require 'themoviedb'
    Tmdb::Api.key("60e2481fc03523c93540e2bdd4b99f47")
    Tmdb::Api.language("en")

    def set_config
  	  @configuration = Tmdb::Configuration.new
    end
end
