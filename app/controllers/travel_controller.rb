class TravelController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]

  def index
    if params[:user_id]
      @travels = Travel.where(user_id: params[:user_id])
    else
      @travels = Travel.all
    end
  end

  def new
    @travel = Travel.new
  end

  def show
    @travel = Travel.find(params[:id])
  end

  def edit
    @travel = Travel.find(params[:id])
    return redirect_to travel_url(params[:id]) if @travel.user_id != current_user.id
  end

  def create
    @travel = Travel.new(travel_params)
    if @travel.save
      redirect_to @travel
    else
      render action: "new"
    end
  end

  def update
    @travel = Travel.find(params[:id])
    return redirect_to travel_path(params[:id]) if @travel.user_id != current_user.id

    if @travel.update_attributes(travel_params)
      redirect_to @travel
    else
      render action: "edit"
    end
  end

  def destroy
    @travel = Travel.find(params[:id])
    @travel.destroy

    redirect_to travel_url
  end

  private

  def travel_params
    params.require(:travel).permit(:title, :startdate, :enddate, :photo_id)
  end
end
