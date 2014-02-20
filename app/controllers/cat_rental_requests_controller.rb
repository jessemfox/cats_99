class CatRentalRequestsController < ApplicationController

  def new
    @request = CatRentalRequest.new
    @cat_ids = Cat.pluck(:id, :name)
    render :new
  end

  def create
    @request = CatRentalRequest.new(cat_rental_params)
    if @request.save
      redirect_to cat_url(@request.cat_id)
    else
      @cat_ids = Cat.pluck(:id, :name)
      flash[:errors] ||= []
      flash[:errors] << @request.errors.full_messages
      render :new
    end
  end

  def approve
    @rental = CatRentalRequest.find(params[:id])
    if @rental.approve!
      redirect_to cat_url(@rental.cat_id)
    else
      flash[:errors] ||= []
      flash[:errors] << @rental.errors.full_messages
      redirect_to cat_url(@rental.cat_id)
    end

  end

  def deny
    @rental = CatRentalRequest.find(params[:id])
    @rental.deny!
    redirect_to cat_url(@rental.cat_id)
  end

  private

  def cat_rental_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end


end
