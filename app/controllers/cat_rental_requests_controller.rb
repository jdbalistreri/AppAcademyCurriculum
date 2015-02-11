class CatRentalRequestsController < ApplicationController
  before_action :require_cat_ownership, only: [:approve, :deny]

  def new
    @request = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end

  def create
    @request = current_user.requests.new(request_params)
    @cat = Cat.find(request_params[:cat_id])
    @cats = Cat.all

    if @request.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def approve
    @request = CatRentalRequest.find(params[:cat_rental_request][:id])
    begin
      @request.approve!
    rescue ActiveRecord::RecordInvalid
    end
    redirect_to cat_url(params[:cat][:id])
  end

  def deny
    @request = CatRentalRequest.find(params[:cat_rental_request][:id])
    begin
      @request.deny!
    rescue ActiveRecord::RecordInvalid
    end
    redirect_to cat_url(params[:cat][:id])
  end

  private
    def request_params
      params.require("cat_rental_request").permit("cat_id", "start_date", "end_date")
    end
end
