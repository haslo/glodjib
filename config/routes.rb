Glodjib::Application.routes.draw do
  get "flickr_images/index"

  root to: 'posts#frontpage'

  scope '/admin' do
    resources :posts, :only => [:index, :new, :create, :edit]
    put 'posts/:id/edit' => 'posts#edit'
    delete 'posts/:id' => 'posts#destroy', :as => :destroy_post
    delete 'reset_caches' => 'flickr_images#reset_caches', :as => :reset_caches
  end

  get 'portfolio' => 'flickr_images#portfolio', :as => :portfolio
  get ':id' => 'posts#show', :as => :post
end
