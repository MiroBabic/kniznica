Rails.application.routes.draw do

  resources :wishlists
   mount LetsencryptPlugin::Engine, at: '/'  # It must be at root level


  devise_for :users, :controllers => {:sessions => "users/sessions", :registrations => "users/registrations"}, :skip => [:registrations]
  
  devise_scope :user do
    match 'users/:id' => 'users/registrations#destroy', :via => :delete, :as => :admin_destroy_user
    post 'modal_edit_user' => 'users/registrations#modal_edit_user', :as => 'modal_edit_user'
    post 'modal_create_user' => 'users/registrations#modal_create_user', :as => 'modal_create_user'
    get 'users/edit' => 'users/registrations#edit', :as => 'edit_user_registration'    
    patch 'users' => 'users/registrations#update', :as => 'user_registration'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

 resources :books
 resources :publishers
 resources :authors

 get 'static_pages/home'
 get '/uzivatelia' => 'static_pages#users', :as => 'users'

 #authors
 post '/modal_create_author' => 'authors#modal_create_author', :as=> 'modal_create_author'
 post '/modal_edit_author' => 'authors#modal_edit_author', :as=> 'modal_edit_author'
  
 #publishers
 post '/modal_create_publisher' => 'publishers#modal_create_publisher', :as=> 'modal_create_publisher'
 post '/modal_edit_publisher' => 'publishers#modal_edit_publisher', :as=> 'modal_edit_publisher'

  root 'static_pages#home'
end
