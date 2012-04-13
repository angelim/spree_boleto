Spree::Order.class_eval do
  has_many :boleto_docs
  
  def payable_via_boleto?
    !!self.class.boleto_payment_method
  end
  
  def self.boleto_payment_method
    Spree::PaymentMethod.where(type: "Spree::PaymentMethod::BoletoMethod").first
  end
end
