Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resource :home, only: [:index]
  resources :trips, only: [:new, :create, :show, :index, :destroy], shallow: true do
    resources :destinations, only: [:new, :create, :destroy], controller: "trips/destinations"
    resources :date_options, only: [:new, :create, :destroy], controller: "trips/date_options"
    resources :invites, only: [:update, :destroy], controller: "trips/invites"
    resources :participants, only: [:new, :create], controller: "trips/participants"
  end

  resources :comments, only: [:new, :create, :destroy]
  resources :votes, only: [:create]
end
