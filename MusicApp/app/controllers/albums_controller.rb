class AlbumsController < ApplicationController
  before_action :require_user

  def new
    @band = Band.find(params[:band_id])
    @bands = Band.all
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to band_url(@album.band_id)
    else
      @band = Band.find(params[:album][:band_id])
      @bands = Band.all
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
    @tracks = @album.tracks
    render :show
  end

  def edit
    @album = Album.find(params[:id])
    @album_name = @album.name
    @band = Band.find(@album.band_id)
    @bands = Band.all
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    @album_name = @album.name

    if @album.update(album_params)
      redirect_to band_url(@album.band_id)
    else
      @band = Band.find(@album.band_id)
      @bands = Band.all
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy!
    redirect_to band_url(@album.band_id)
  end

  private
    def album_params
      params.require(:album).permit(:band_id, :name, :recording_year, :recording_type)
    end

end
