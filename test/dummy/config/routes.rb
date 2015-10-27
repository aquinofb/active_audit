Rails.application.routes.draw do

  resources :orders
  resources :products
  mount ActiveAudit::Engine => "/active_audit"
end
