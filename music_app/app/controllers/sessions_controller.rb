class SessionsController < ApplicationController
    before_action :require_logged_in, only: [:destroy] 
    before_action :require_logged_out, only: [:new, :create]
    def new
        @user = User.new
        render :new
    end
    
    def create
        @user = User.find_by_credentials(params[:user][:email], params[:user][:password])

        if @user.nil?
            flash.now[:errors] = ["There was an error with your email or password. Please try again"]
            @user = User.new
            render :new
        else
            login!(@user)
            redirect_to user_url(@user)
        end
    end

    def destroy
        if self.logged_in?
            flash[:messages] = ["You have been logged out."]
            self.logout!
        end
    end
end