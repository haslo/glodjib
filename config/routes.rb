Glodjib::Application.routes.draw do

  # root and feed

  root 'home#index'
  get '/feed' => 'posts#feed', :as => :feed, :defaults => { :format => 'atom' }

  # posts, pages

  resources :posts, :path => 'blog'
  resources :pages

  # comments, images, tags

  resources :post_comments, :path => 'blog/comment', :only => [:new, :create, :destroy] do
    delete :spam, :path => 'spam'
  end
  resources :portfolios, :path => 'gallery', :portfolio => 'portfolio', :only => [:show, :edit] do
    patch :sort
    get :check_reset
  end
  resources :flickr_images, :path => 'image', :only => [:show]
  resources :post_tags, :path => 'blog/tags', :only => [:show]

  # admin stuff

  devise_for :users, :path_names => {:sign_in => 'login', :sign_out => 'logout'}
  resources :settings, :only => [:index, :update] do
    get :parameters, :on => :collection
    get :images, :on => :collection
    delete :reset_cache, :path => 'reset_cache/:tag', :on => :collection
    delete :reset_caches, :path => 'reset_caches', :on => :collection
    delete :destroy_cache, :path => 'destroy_cache/:tag', :on => :collection
    delete :destroy_caches, :path => 'destroy_caches', :on => :collection
  end

end
