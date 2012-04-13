Spree::Core::Engine.routes.prepend do
  namespace :admin do
    resources :boleto_docs
  end
  resources :boleto_docs
end