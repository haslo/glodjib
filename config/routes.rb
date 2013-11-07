Glodjib::Application.routes.draw do
  root 'posts#frontpage'

  scope '/admin' do
    devise_for :users, :path_names => {:sign_in => 'login', :sign_out => 'logout'}
    resources :posts, :only => [:edit, :update, :destroy]
    resources :post_comments, :only => [:destroy] do
      delete :spam, :path => ':id/spam'
    end
    resources :flickr_images, :path => :portfolio, :only => [] do
      delete :reset_caches, :on => :collection
    end
    resources :settings, :only => [:index, :update]
  end
  resources :post_tags, :only => [:show]
  resources :flickr_images, :path => :portfolio, :only => [:index, :show]
  resources :posts, :path => '', :only => [:show], :as => :post
  resources :post_comments, :path => 'comment', :only => [:create]
end
