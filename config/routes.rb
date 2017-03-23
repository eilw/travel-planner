Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resource :home, only: [:index]
  resources :trips, only: [:new, :create, :show, :index], shallow: true do
    resources :destinations, only: [:new, :create], controller: "trips/destinations", shallow: true do
      resources :comments, only: [:new, :create], controller: "alternatives/comments"
    end

    resources :invites, only: [:new, :create ], controller: "trips/invites" do
      get :rvsp, on: :member
    end
  end
end
