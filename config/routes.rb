Rails.application.routes.draw do
  root 'home#index'

  devise_for :users
  resources :promotions, only: %i[index show new create edit update destroy] do
    post 'generate_coupons', on: :member
  end

  resources :coupons, only: [] do
    post 'inactivate', on: :member
  end

end
