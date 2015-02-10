class CatRentalRequestsController < ApplicationController
  def index
    @cat = Cat.find(params[:cat_id])
    render :index
  end

  def new
    @request = CatRentalRequest.new
    @cat = Cat.find(params[:cat_id])
    render :new
  end

  def create
    @request = CatRentalRequest.new(request_params)
    @cat = Cat.find(request_params[:cat_id])

    if @request.save
      render :index
    else
      render :new
    end
  end

  private
    def request_params
      params.require("cat_rental_request").permit("cat_id", "start_date", "end_date")
    end
end
