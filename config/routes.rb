Rails.application.routes.draw do
  resources :comments, only: [:create, :destroy] do
    collection do
      get :my_comments
      get :comments_to_me
    end
  end
  resources :blogs do
    collection do
      get :my_posts
    end
  end

  resources :users do
    collection do
      get :my_profile
      get :settings
    end
  end

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
		delete 'logout' => :destroy
  end

  get 'signup', to: 'users#new', as: :sign_up


  root 'blogs#index'
end
