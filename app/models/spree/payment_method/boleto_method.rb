module Spree
  class PaymentMethod::BoletoMethod < PaymentMethod
    preference :bank, :string
    preference :routing_number, :string
    preference :account_number, :string
    preference :account_owner_name, :string
    preference :currency, :string
    preference :due_in, :integer
    preference :payment_location, :string
    preference :accept_after_due, :string
    preference :contract, :string
    preference :store_document, :string
    preference :format, :string
    
    FORMATS={
      'pdf' => 'application/pdf',
      'jpg' => 'image/jpg',
      'tif' => 'image/tiff',
      'png' => 'image/png'
    }
    
    def payment_source_class
      Boleto
    end
  end
end