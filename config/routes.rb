Rails.application.routes.draw do
    root to: "blog/posts#index"

    devise_for :authors, :controllers => { registrations: 'registrations' }

    namespace :authors do
        get '/my-account' => 'accounts#get_update'
        put '/my-account/info' => 'accounts#update_info'
        put '/my-account/password' => 'accounts#update_password'

        resources :posts
    end

    scope module: "blog" do
        resources :posts, only: [:index, :show]
    end
end
