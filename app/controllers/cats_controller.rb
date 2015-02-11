class CatsController < ApplicationController
  before_action :require_user!, only: [:new, :create]
  before_action :require_cat_ownership, only: [:edit, :update, :destroy]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @request = CatRentalRequest.new
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = current_user.cats.new(cat_params)

    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    @cat.update(cat_params)

    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  def destroy
    @cat = Cat.find(params[:id])
    @cat.destroy!
    redirect_to cats_url
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :color, :sex, :birth_date,
                                :description)
  end

end
