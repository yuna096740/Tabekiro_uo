Rails.application.routes.draw do

  devise_for :members, controllers: {
    registrations: "public/registrations",
    sessions:      "public/sessions",
    passwords:     "public/passwords"
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'

    resources :members, only: [:index, :show] do
      resources :relationships, only: [:create, :destroy] do
        collection do
          get 'subscriber'
          get 'subscribed'
        end
      end
      collection do
        get   'favorite'
        get   'confirm'
        patch 'quit'
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
    resources :searches, only: [:index]
    resources :tags,     only: [:show]
    resources :rooms,    only: [:show, :create, :destroy]
    resources :messages, only: [:create, :destroy]
    resources :reports,  only: [:new, :create] do
      collection do
        get 'confirm'
      end
    end

  end

  namespace :admin do
    get '/' => 'homes#top'

    resources :members, only: [:index, :show, :update] do
      member do
        get 'report'
      end
    end
    resources :searches, only: [:index]
    resources :reports,  only: [:show, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
