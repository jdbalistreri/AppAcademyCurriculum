class TracksController < ApplicationController

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def new
    @track = Track.new
    @album = Album.find(params[:album_id])
    @albums = Album.all

    render :new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to album_url(@track.album_id)
    else
      @album = Album.find(@track.album_id)
      @albums = Album.all
      render :new
    end
  end

  def edit

  end

  def update
  end

  def destroy

  end

  private
    def track_params
      params.require(:track).permit(:lyrics, :name, :album_id, :track_type)
    end
end
