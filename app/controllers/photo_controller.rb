class PhotoController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :destroy]
  before_action :set_album

  def index
  end

  def create
    @photo = Photo.new(params[:photo])
    if @photo.save
      redirect_to @photo
    else
      render action: "new"
    end
  end

  def new
  end

  def show
  end

  def destroy
  end

  private

  def set_album
    @album = Travel.find(params[:travel_id]).albums.find(params[:album_id])
  end

end
