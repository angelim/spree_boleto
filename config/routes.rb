Spree::Core::Engine.routes.prepend do
  scope :admin do
    resources :boletos
  end
end