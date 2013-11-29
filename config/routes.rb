Glodjib::Application.routes.draw do

  root 'home#index'
  get '/feed' => 'posts#feed', :as => :feed, :defaults => { :format => 'atom' }

  scope '/admin' do
    devise_for :users, :path_names => {:sign_in => 'login', :sign_out => 'logout'}
    resources :posts, :except => :show
    resources :post_comments, :only => [:destroy] do
      delete :spam, :path => 'spam'
    end
    resources :flickr_images, :path => :portfolio, :only => [] do
      delete :reset_caches, :on => :collection
    end
    resources :settings, :only => [:index, :create]
  end

  resources :post_tags, :only => [:show]
  resources :flickr_images, :path => 'gallery/:portfolio', :portfolio => 'portfolio', :only => [:index]
  resources :posts, :path => '', :only => [:show] do
    get 'blog', :action => 'index', :on => :collection, :as => 'blog'
  end
  resources :post_comments, :path => 'comment', :only => [:new, :create]

end
