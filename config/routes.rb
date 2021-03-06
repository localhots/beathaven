BeatHaven::Application.routes.draw do
  namespace :api do
    resources :artists, only: [:show], constraints: { id: /.+/ }, format: :json
    resources :albums, only: [:show, :picture], format: :json do
      member { get :picture }
    end
    resources :search, only: [] do
      collection { get :complete; get :wtfis }
    end
    resources :session, only: [] do
      collection { get :auth }
    end
  end

  match "/:path" => "application#main", constraints: { path: /.*/ }
  root to: "application#main"
end
