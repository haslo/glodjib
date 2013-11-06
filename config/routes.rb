Glodjib::Application.routes.draw do
  root 'posts#frontpage'

  scope '/admin' do
    devise_for :users, :path_names => {:sign_in => 'login', :sign_out => 'logout'}
    resources :posts, :only => [:index, :new, :create, :edit]
    delete 'post_comment/:id' => 'post_comments#destroy', :as => 'destroy_post_comment'
    delete 'post_comment/spam/:id' => 'post_comments#spam', :as => 'spam_post_comment'
    patch 'posts/:id/edit' => 'posts#edit'
    delete 'posts/:id' => 'posts#destroy', :as => :destroy_post
    delete 'reset_caches' => 'flickr_images#reset_caches', :as => :reset_caches
    get 'settings' => 'settings#index', :as => :settings
    post 'settings' => 'settings#index', :as => :update_settings
  end

  scope '/tag' do
    get ':id' => 'post_tags#show', :as => :post_tag
  end

  get 'portfolio' => 'flickr_images#portfolio', :as => :portfolio
  get ':id' => 'posts#show', :as => :post
  post ':post_id' => 'post_comments#create', :as => :post_comment
end
