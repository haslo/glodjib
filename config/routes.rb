Glodjib::Application.routes.draw do
  root to: 'posts#frontpage'

  scope '/admin' do
    devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
    resources :posts, :only => [:index, :new, :create, :edit]
    put 'posts/:id/edit' => 'posts#edit'
    delete 'posts/:id' => 'posts#destroy', :as => :destroy_post
    delete 'reset_caches' => 'flickr_images#reset_caches', :as => :reset_caches
  end

  scope '/tag' do
    get ':id' => 'post_tag#show', :as => :post_tag
  end

  get 'portfolio' => 'flickr_images#portfolio', :as => :portfolio
  get ':id' => 'posts#show', :as => :post
end
