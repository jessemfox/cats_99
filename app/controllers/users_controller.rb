
class UsersController < ApplicationController
  before_action :check_logged_in, :only => [:create, :new]

  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      log_in!
    else
      flash.now[:errors] = []
      flash.now[:errors] << @user.errors.full_messages
      render :new
    end

  end

  def show
    @user = User.find(params[:id])
    @sessions = Session.where('user_id = ?', @user.id)
    # @sessions.first = @sessions.first.parse_meta_info
  end


  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
