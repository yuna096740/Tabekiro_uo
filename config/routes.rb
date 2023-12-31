Rails.application.routes.draw do

  devise_for :members, controllers: {
    registrations: "public/registrations",
    sessions:      "public/sessions",
    passwords:     "public/passwords"
  }
  
  devise_scope :member do
    post "members/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root to: 'homes#top'
    get '/about'          => 'homes#about', as: 'about'

    resources :members, only: [:index, :show] do
      collection do
        get   'favorite'
        get   'deal'
        get   'quit_form'
        post  'confirm'
        patch 'quit'
      end
      resource :relationships, only: [:create, :destroy] do
        collection do
          get 'subscribings'
          get 'subscribers'
        end
      end
      resources :reports,  only: [:new, :create, :show] do
        collection do
          post 'confirm'
        end
      end
    end
    get   'members/information/edit' => 'members#edit'
    patch 'members/information'      => 'members#update'

    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
      resource  :favorites,     only: [:create, :destroy]
      collection do
        get 'map'
      end
    end

    resources :notifications, only: [:destroy] do
      collection do
        delete 'destroy_all'
        patch  'notice'
      end
    end

    resources :searches,    only: [:index]
    resources :tags,        only: [:show]
    resources :rooms,       only: [:show, :create, :destroy]
    resources :messages,    only: [:create, :destroy]
    resources :vision_tags, only: [:show]
  end

  namespace :admin do
    get '/' => 'homes#top'

    resources :members, only: [:index, :show, :update] do
      member do
        get 'report'
      end
    end
    resources :searches, only: [:index, :show]
    resources :reports,  only: [:show, :update]
    resources :tags,     only: [:index, :create, :edit, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
