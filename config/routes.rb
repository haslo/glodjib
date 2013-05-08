Glodjib::Application.routes.draw do
  get "flickr_images/index"

  root to: 'posts#index'

  scope '/admin' do
    resources :posts, :only => [:index, :new, :create]
  end
  resources :flickr_images, :only => [:index, :new, :create]

  match 'portfolio' => 'flickr_images#portfolio', :as => :portfolio
  match ':id' => 'posts#show', :as => :post
end
