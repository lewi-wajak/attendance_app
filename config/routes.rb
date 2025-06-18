Rails.application.routes.draw do
  namespace :admin do
    get "users/index"
    get "dashboard/index"
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  root 'attendances#index';

  resources :attendances, only: [:index] do
    collection do
      post :check_in
      patch :check_out
    end
  end

 namespace :admin do
  get 'dashboard', to: 'dashboard#index'
  resources :users, only: [:index] do
    member do
      patch :update_role   # Add this line
    end
  end

end
end
