Travelphoto::Application.routes.draw do

  resources :travel do
    resources :album do
      resources :photo
    end
    member do
      get :cover_photo
    end
  end

  devise_for :admins
  devise_for :users

  root :to => "home#index"

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
end
