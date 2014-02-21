class SessionsController < ApplicationController
  before_action :check_logged_in, :only => [:create, :new]

  def create
    @user = User.find_by_credentials(params[:user])
    if @user
      log_in!
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << @user.errors.full_messages unless @user.nil?
      redirect_to new_session_url
    end
  end


  def new
    @user = User.new
  end

  def destroy
    self.logout!
    redirect_to new_session_url
  end

  def kill_session
    user_session = Session.find(params[:id])
    session_token = session[:session_token]
    db_session = user_session.session_token
    redirect_to "/" unless current_user && current_user.id = user_session.user_id
    user_session.destroy
    if session_token == db_session
      redirect_to "/"
    else
      redirect_to user_url(current_user)
    end
  end

end
