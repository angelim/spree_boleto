module Spree
  class BoletoDoc < ActiveRecord::Base
    # status: issued, cancelled, paid
    serialize :payload
    has_one :payment, :as => :source
    belongs_to :order
    attr_accessor :vencimento_fixo
    
    [:pending, :cancelled, :paid].each do |state|
      scope state, where("status = ?", state.to_s)
    end
    scope :active, where("status != ?", "cancelled")
    
    def process!(payment)
      order = payment.order
      prefs = Spree::Boleto::Configuration.preferences.dup
      banco = prefs.delete(:banco).classify      
      formato = prefs.delete(:formato)
      parcelas = prefs.delete(:parcelas)
      @boleto = "Brcobranca::Boleto::#{banco}".constantize.new(prefs)
      @boleto.sacado = order.name
      @boleto.valor = payment.amount
      @boleto.numero_documento = id
      @boleto.data_documento = Date.today
      @boleto.sacado_endereco = order.bill_address.full_address
      @boleto.sacado_documento = order.bill_address.document
      @boleto.vencimento_fixo = due_date
      self.payload = @boleto
      self.document_number = @boleto.numero_documento
      save
      payment.pend
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
      update_attribute(:status, "paid")
      payment.complete
      true
    end

    def void(payment)
      update_attribute(:status, "cancelled")
      payment.void
      true
    end
  end
end
