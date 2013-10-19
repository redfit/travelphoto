Travelphoto::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :travel

  devise_for :admins
  devise_for :users

  root :to => "home#index"
end
