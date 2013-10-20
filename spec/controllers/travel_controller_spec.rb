require 'spec_helper'

describe TravelController do

  def travel_params
    FactoryGirl.attributes_for(:travel)
  end

  before do
    @different_user = FactoryGirl.create(:user_with_10_travels)
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

  describe "#show" do
    it "assigns the requested travel as @travel" do
      travel = Travel.first
      get :show, {id: travel.id}
      expect(assigns(:travel)).to eq travel
    end
  end

  describe "#new" do
    login_user
    it "access to new, dose not work without a signed in user" do
      sign_out :user
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it "assigns as new travel as @travel when sign in" do
      get :new
      expect(assigns(:travel)).to be_a_new(Travel)
    end
  end

  describe "#edit" do
    login_user
    it "access to edit, does not work without a signed in user" do
      sign_out :user
      travel = User.first.travels.first
      get :edit, { id: travel.id}
      expect(response).to redirect_to(new_user_session_path)
    end

    it "assign as edit travel as @travel when sign in" do
      travel = @current_user.travels.first
      get :edit, {id: travel.id}
      expect(assigns(:travel)).to eq travel
    end

    it "access to edit, does not work when sign in as another user" do
      travel = @different_user.travels.first
      get :edit, {id: travel.id}
      expect(response).to redirect_to(travel)
    end
  end

  describe "#POST create" do
    context "without login" do
      it "should be redirect to login page" do
        sign_out :user
        post :create
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context "with login" do
      login_user
      it "create new Travel" do
        expect{
          post :create, travel: travel_params
        }.to change(Travel, :count).by(1)
      end

      it "create new travel as @travel" do
        post :create, travel: travel_params
        expect(assigns(:travel)).to be_a(Travel)
      end

      it "doesn't create new travel with invaild params" do
        Travel.any_instance.stub(:save).and_return(false)
        post :create, travel: travel_params
        expect(assigns(:travel)).to be_a_new(Travel)
      end

      it "doesn't create new travel with invaild params" do
        Travel.any_instance.stub(:save).and_return(false)
        post :create, travel: travel_params
        expect(response).to render_template("new")
      end
    end
  end

  describe "#POST update" do
    login_user
    context "without login" do
      it "should be redirect to login page" do
        sign_out :user
        travel = @current_user.travels.first
        patch :update, {id: travel.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "another user" do
      it "should be redirect to another page" do
        travel = @current_user.travels.first
        patch :update, {id: travel.id, travel: travel_params}
        expect(response).to redirect_to(travel)
      end
    end

    describe "with vaild params" do
      it "assigns the requested travel as @travel" do
        travel = @current_user.travels.first
        patch :update, {id: travel.id, travel: travel_params}
        assigns(:travel).should eq(travel)
      end

      it "redirects to the travel" do
        travel = @current_user.travels.first
        patch :update, {id: travel.id, travel: travel_params}
        response.should redirect_to(travel)
      end
    end

    describe "with invalid params" do
      it "assigns the travel as @travel" do
        travel = @current_user.travels.first
        Travel.any_instance.stub(:save).and_return(false)
        patch :update, {id: travel.id, travel: travel_params}
        expect(assigns(:travel)).to eq travel
      end

      it "re-renders the 'edit' template" do
        travel = @current_user.travels.first
        Travel.any_instance.stub(:save).and_return(false)
        patch :update, {id: travel.id, travel: travel_params}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    login_user
    describe "without login" do
      it "should be redirect to login page" do
        sign_out :user
        travel = @current_user.travels.first
        delete :destroy, {id: travel.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "another user" do
      it "should be redirect to another page" do
        travel = @current_user.travels.first
        delete :destroy, {id: travel.id}
        expect(response).to redirect_to(travel)
      end
    end

    it "destroys the requested Travel" do
      travel = @current_user.travels.first
      expect {
        delete :destroy, {id: travel.id}
      }.to change(Travel, :count).by(-1)
    end

    it "redirects to the travels list" do
      travel = FactoryGirl.create(:travel)
      delete :destroy, {:id => travel.id}
      expect(response).to redirect_to(travel_url)
    end
  end

  def set_up_data
    @travel = @current_user.travels.first
    @album = FactoryGirl.create(:album, travel: @travel)
    @photo = FactoryGirl.create(:photo, album: @album, user: @current_user)
    @travel.cover_photo = @photo
    @travel.save
  end

  describe "GET cover_photo" do
    login_user

    before(:each) do
      set_up_data
    end

    it "should be return cover_photo" do
      get :cover_photo, {id: @travel.id}
      expect(assigns(:photo)).to eq @photo
    end
  end

  describe "POST cover_photo" do
    login_user

    before(:each) do
      set_up_data
    end

    it "access to cover_photo does not work without a signed in user" do
      sign_out :user
      post :cover_photo, {id: @travel.id, photo_id: @photo.id}
      expect(response).to redirect_to(new_user_session_path)
    end

    it "access to edit, does not work when sign in as another user" do
      sign_in :user, @different_user
      post :cover_photo, {id: @travel.id, photo_id: @photo.id}
      expect(response).to redirect_to(@travel)
    end

    it "should be set cover_photo" do
      @travel.cover_photo = nil
      @travel.save
      post :cover_photo, {id: @travel.id, photo_id: @photo.id}
      expect(Travel.find(@travel.id).cover_photo.id).to eq @photo.id
    end
  end
end
