class TravelController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  def index
    if params[:user_id]
      @travels = Travel.where(user_id: params[:user_id])
    else
      @travels = Travel.all
    end
  end
end
