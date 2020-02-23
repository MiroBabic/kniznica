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

 #books
 post '/modal_create_book' => 'books#modal_create_book', :as=> 'modal_create_book'
 post '/modal_edit_book' => 'books#modal_edit_book', :as=> 'modal_edit_book'
 get '/chart_total_books' => 'books#chart_total_books', :as=> 'chart_total_books'
 get '/chart_top_book_publishers' => 'books#chart_top_book_publishers', :as=> 'chart_top_book_publishers'
 get '/chart_top_book_authors' => 'books#chart_top_book_authors', :as=> 'chart_top_book_authors'

#wishlists
post '/modal_create_wishlist' => 'wishlists#modal_create_wishlist', :as=> 'modal_create_wishlist'
post '/modal_edit_wishlist' => 'wishlists#modal_edit_wishlist', :as=> 'modal_edit_wishlist'
post '/update_from_martinus' => 'wishlists#update_from_martinus', :as=> 'update_from_martinus'
post '/move_from_wishlist' => 'wishlists#move_from_wishlist', :as=> 'move_from_wishlist'
get '/chart_total_wishlist' => 'wishlists#chart_total_wishlist', :as=> 'chart_total_wishlist'

  root 'static_pages#home'
end
