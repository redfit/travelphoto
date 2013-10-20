class AlbumController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :edit, :create, :update, :destroy]
  before_action :set_travel

  def index
    @albums = @travel.albums
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to @album
    else
      render action: "new"
    end
  end

  def new
    @album = @travel.albums.build
  end

  def edit
    @album = Album.find(params[:id])
  end

  def show
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])

    if @album.update_attributes(album_params)
      redirect_to @travel
    else
      render action: "edit"
    end
  end

  def destroy
    @album = Albim.find(params[:id])
    @album.destroy if @travel.album.length > 1

    redirect_to travel_album_index_url
  end

  private

  def album_params
    params.require(:album).permit(:title)
  end

  def set_travel
    @travel = Travel.find(params[:travel_id])
  end
end
