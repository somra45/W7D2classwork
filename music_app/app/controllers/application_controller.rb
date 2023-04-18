class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?

    skip_before_action :verify_authenticity_token
    def current_user
        @current_user = User.find_by(session_token: session[:session_token])
        @current_user
    end

    def logged_in?
        !!current_user
    end

    def login!(user)
        user.reset_session_token!
        session[:session_token] = user.session_token
    end

    def logout!
        current_user.reset_session_token!
        session[:session_token] = nil
        redirect_to new_session_url
    end

    def require_logged_in
        unless logged_in? 
            flash[:messages] = ["You must be logged in to access this page."]
            redirect_to user_url(current_user)
        end
    end

    def require_logged_out
        unless !logged_in?
            flash[:messages] = ["You must be logged out to access this page."]
            redirect_to new_session_url
        end
    end
end
