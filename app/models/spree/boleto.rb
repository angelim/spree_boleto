module Spree
  class Boleto < ActiveRecord::Base
    # status: issued, cancelled, paid
    
    validates_presence_of :due_date, :order_id, :status, :amount, :payload, :document_number
    has_one :payment, :as => :source
    belongs_to :order
    
    def process!(payment)
      order = payment.order
      banco = PaymentMethod::BoletoMethod.preferred_bank.to_sym

      @boleto = case banco
        when :itau then Brcobranca::Boleto::Itau.new
        when :bb then  Brcobranca::Boleto::BancoBrasil.new
        when :hsbc then Brcobranca::Boleto::Hsbc.new
        when :real then Brcobranca::Boleto::Real.new
        when :bradesco then Brcobranca::Boleto::Bradesco.new
        when :unibanco then Brcobranca::Boleto::Unibanco.new
        when :caixa then Brcobranca::Boleto::Caixa.new
      end

      @boleto.cedente = PaymentMethod::BoletoMethod.preferred_account_owner_name
      @boleto.agencia = PaymentMethod::BoletoMethod.preferred_routing_number
      @boleto.conta_corrente = PaymentMethod::BoletoMethod.preferred_account_number
      @boleto.documento_cedente = PaymentMethod::BoletoMethod.preferred_store_document
      @boleto.convenio = PaymentMethod::BoletoMethod.preferred_contract
      @boleto.dias_vencimento = PaymentMethod::BoletoMethod.preferred_due_in
      @boleto.sacado = order.name
      @boleto.valor = order.amount
      @boleto.numero_documento = id
      @boleto.data_documento = Date.today
      @boleto.sacado_endereco = order.bill_address.full_address
      @boleto.instrucao1 = "Pagável na rede bancária até a data de vencimento."
      @boleto.instrucao2 = "Juros de mora de 2.0% mensal(R$ 0,09 ao dia)"
      @boleto.instrucao3 = "DESCONTO DE R$ 29,50 APÓS 05/11/2006 ATÉ 15/11/2006"
      @boleto.instrucao4 = "NÃO RECEBER APÓS 15/11/2006"
      @boleto.instrucao5 = "Após vencimento pagável somente nas agências do Banco do Brasil"
      @boleto.instrucao6 = "ACRESCER R$ 4,00 REFERENTE AO BOLETO BANCÁRIO"
      

      formato = PaymentMethod::BoletoMethod.preferred_format
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
