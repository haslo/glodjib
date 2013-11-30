Glodjib::Application.routes.draw do

  # root and feed

  root 'home#index'
  get '/feed' => 'posts#feed', :as => :feed, :defaults => { :format => 'atom' }

  # posts, pages

  resources :posts, :path => 'blog'
  resources :pages

  # comments, images, tags

  resources :post_comments, :path => 'comment', :only => [:new, :create, :destroy] do
    delete :spam, :path => 'spam'
  end
  resources :flickr_images, :path => 'gallery/:portfolio', :portfolio => 'portfolio', :only => [:index, :show] do
    delete :reset_caches, :on => :collection
  end
  resources :post_tags, :path => 'tags', :only => [:show]

  # admin stuff

  devise_for :users, :path_names => {:sign_in => 'login', :sign_out => 'logout'}
  resources :settings, :only => [:index, :create]

end
