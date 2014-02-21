module SessionsHelper

  def current_user
    return nil if session[:session_token].nil?
    user_session = Session.find_by_session_token(session[:session_token])
    if user_session.nil?
      session[:session_token] = nil
    elsif user_session.session_token = session[:session_token]
      @current_user ||= User.find(user_session.user_id)
    else
      nil
    end
  end


  def logout!
    # current_user.reset_session_token!
    Session.find_by_session_token(session[:session_token]).destroy
    session[:session_token] = nil
    # session[:session_id] = nil
  end



  def log_in!
    # @user.reset_session_token!
    user_session = Session.new(:user_id => @user.id, :ip => request.remote_ip, :user_agent => request.env['HTTP_USER_AGENT'])
    user_session.save!
    session[:session_token] = user_session.session_token
    # session[:session_id] = user_session.id
    redirect_to user_url(@user)
  end

  def check_logged_in
    if current_user
      redirect_to user_url(@current_user)
    end
  end

end

