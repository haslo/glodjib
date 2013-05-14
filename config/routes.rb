Glodjib::Application.routes.draw do
  get "flickr_images/index"

  root to: 'posts#frontpage'

  scope '/admin' do
    resources :posts, :only => [:index, :new, :create]
    match 'reset_caches' => 'flickr_images#reset_caches', :as => :reset_caches
  end
  resources :flickr_images, :only => [:index, :new, :create]

  match 'portfolio' => 'flickr_images#portfolio', :as => :portfolio
  match ':id' => 'posts#show', :as => :post
end
