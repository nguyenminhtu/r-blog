Rails.application.routes.draw do
  root to: "blog/posts#index"

  devise_for :authors, :controllers => { registrations: 'registrations' }

  namespace :authors do
      get '/my-account' => 'accounts#get_update'
      put '/my-account/info' => 'accounts#update_info'
      put '/my-account/password' => 'accounts#update_password'
      put '/my-account/avatar' => 'accounts#update_avatar'

      resources :posts
  end

  scope module: "blog" do
      resources :posts, only: [:index, :show] do
          put "/child/:id" => "comments#child_comment"

          resources :comments
      end
  end
end
