BeatHaven::Application.routes.draw do
  namespace :api do
    resources :artists, only: [:show], constraints: { id: /.+/ }
    resources :albums, only: [:picture] do
      member { get :picture }
    end
  end

  root to: "application#main"
end
