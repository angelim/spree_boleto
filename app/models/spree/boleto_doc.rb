module Spree
  class BoletoDoc < ActiveRecord::Base
    # status: issued, cancelled, paid
    
    validates_presence_of :due_date, :order_id, :status, :amount, :payload, :document_number
    has_one :payment, :as => :source
    belongs_to :order
    
    def process!(payment)
      order = payment.order
      prefs = Spree::Boleto::Configuration.preferences.dup
      banco = prefs.delete(:banco).classify      
      formato = prefs.delete(:formato)
      @boleto = "Brcobranca::Boleto::#{banco}".constantize.new(prefs)
      @boleto.sacado = order.name
      @boleto.valor = order.amount
      @boleto.numero_documento = id
      @boleto.data_documento = Date.today
      @boleto.sacado_endereco = order.bill_address.full_address
      
      headers['Content-Type']= PaymentMethod::BoletoMethod::FORMATS[formato]
      send_data @boleto.to(formato), :filename => "boleto_#{banco}_#{id}.#{formato}"
    end
    
    def actions
      %w{capture void}
    end

    # Indicates whether its possible to capture the payment
    def can_capture?(payment)
      ['processing', 'checkout', 'pending'].include?(payment.state)
    end

    # Indicates whether its possible to void the payment.
    def can_void?(payment)
      payment.state != 'void'
    end

    def capture(payment)
      payment.update_attribute(:state, 'pending') if payment.state == 'checkout'
      payment.complete
      true
    end

    def void(payment)
      payment.update_attribute(:state, 'pending') if payment.state == 'checkout'
      payment.void
      true
    end
  end
end
