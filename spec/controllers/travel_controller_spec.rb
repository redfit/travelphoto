require 'spec_helper'

describe TravelController do

  before do
    FactoryGirl.create(:user_with_10_travels)
  end

  describe "#index" do
    context "when user don't logged in" do
      it "shows all data when user don't logged in" do
        travels = Travel.all
        get :index
        expect(assigns(:travels)).to match_array travels
      end

    end

    context "when user logged in" do
      login_user
      it "show user data when requested with user_id" do
        travels = Travel.all
        get :index
        expect(assigns(:travels)).to match_array travels
      end

      it "show user data when requested with user_id" do
        travels = Travel.where(user: @current_user)
        get :index, {user_id: @current_user.id}
        expect(assigns(:travels)).to match_array travels
      end
    end
  end
end
