Rails.application.routes.draw do

  namespace :admin do
    get 'searches/index'
  end
  namespace :admin do
    get 'members/index'
    get 'members/show'
  end
  namespace :admin do
    get 'reports/show'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'reports/new'
  end
  namespace :public do
    get 'rooms/show'
  end
  namespace :public do
    get 'tags/show'
  end
  namespace :public do
    get 'searches/index'
  end
  namespace :public do
    get 'posts/index'
    get 'posts/show'
    get 'posts/new'
    get 'posts/edit'
  end
  namespace :public do
    get 'members/index'
    get 'members/show'
    get 'members/edit'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  devise_for :members, controllers: {
    registrations: "public/registrations",
    sessions:      "public/sessions",
    passwords:     "public/passwords"
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
