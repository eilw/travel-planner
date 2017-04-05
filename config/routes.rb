Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resource :home, only: [:index]
  resources :trips, only: [:new, :create, :show, :index], shallow: true do
    resources :destinations, only: [:new, :create], controller: "trips/destinations"
    resources :date_options, only: [:new, :create], controller: "trips/date_options"

    resources :invites, only: [:new, :create, :destroy], controller: "trips/invites" do
      get :rvsp, on: :member
    end
  end

  resources :comments, only: [:new, :create]
  resources :votes, only: [:create]
end
