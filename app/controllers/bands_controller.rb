class BandsController < ApplicationController

  def index
    @bands = Band.all
  end

  def show
    @band = Band.find(params[:id])
    @albums = @band.albums
    render :show
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      redirect_to bands_url
    else
      render :new
    end
  end

  def edit
    @band = Band.find(params[:id])
    @band_name = @band.name
    render :edit
  end

  def update
    @band = Band.find(params[:id])
    @band_name = @band.name
    
    if @band.update(band_params)
      redirect_to band_url(@band)
    else
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy!
    redirect_to bands_url
  end

  private
    def band_params
      params.require(:band).permit(:name)
    end

end
