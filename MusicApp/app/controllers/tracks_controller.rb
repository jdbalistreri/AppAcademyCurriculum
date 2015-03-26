class TracksController < ApplicationController
  before_action :require_user

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
    @track = Track.find(params[:id])
    @track_name = @track.name
    @albums = Album.all
    @album = @track.album
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    @track_name = @track.name

    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      @albums = Album.all
      @album = @track.album
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy!
    redirect_to album_url(@track.album_id)
  end

  private
    def track_params
      params.require(:track).permit(:lyrics, :name, :album_id, :track_type)
    end
end
