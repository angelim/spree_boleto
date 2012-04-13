Spree::Core::Engine.routes.prepend do
  scope :admin do
    resources :boleto_docs
  end
  resources :boleto_docs
end