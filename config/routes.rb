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
  resources :portfolios, :only => [:show]
  resources :images, :only => [:show]
  resources :post_tags, :path => 'tags', :only => [:show]

  # admin stuff

  devise_for :users, :path_names => {:sign_in => 'login', :sign_out => 'logout'}

  namespace :admin do
    resources :galleries, :except => [:view] do
      post :import, :path => 'import/:source'
      patch :reorder_galleries, :on => :collection
      patch :reorder_images
      get :is_updated
    end
    resources :settings, :only => [:index, :update]
  end

end
