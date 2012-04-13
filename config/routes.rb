Spree::Core::Engine.routes.prepend do
  namespace :admin do
    resources :boleto_docs
  end
  resources :orders do
    resources :boleto_docs
  end
end