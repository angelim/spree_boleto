# encoding:utf-8
module Spree
  class PaymentMethod::BoletoMethod < PaymentMethod
    
    FORMATS={
      'pdf' => 'application/pdf',
      'jpg' => 'image/jpg',
      'tif' => 'image/tiff',
      'png' => 'image/png'
    }
    
    def payment_source_class
      BoletoDoc
    end
  end
end