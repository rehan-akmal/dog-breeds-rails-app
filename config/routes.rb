Rails.application.routes.draw do
  root 'breeds#index'
  post 'fetch_breed_image', to: 'breeds#fetch_breed_image'
end
