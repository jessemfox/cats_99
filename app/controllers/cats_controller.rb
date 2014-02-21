class CatsController < ApplicationController
  before_action :is_cat_owner, only: [:edit, :update]
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = params[:user_id]
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << @cat.errors.full_messages
      render :new
    end

  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])

    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << @cat.errors.full_messages
      render :edit
    end
  end

  def destroy

  end


  def is_cat_owner

    redirect_to "/" unless current_user.id == Cat.find(params[:id]).user_id

  end

  private

  def cat_params
    params.require(:cat).permit(:age, :name, :birthdate, :color, :sex)
  end

end
