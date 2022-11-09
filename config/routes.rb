Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/slot', to: 'home#slot', as: 'slot'
  post '/slot_collection', to: 'home#slot_collection', as: 'slot_collection'
  get '/slot_booking', to: 'home#slot_booking', as: 'slot_bookings'
end
