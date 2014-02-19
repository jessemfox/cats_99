class CatsController < ApplicationController

  def index

  end

  def show

  end

  def new


  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end


  private

  def cat_params
    params.require(:cat).permit(:age, :name, :birthdate, :color, :sex)
  end

end
