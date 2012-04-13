# encoding:utf-8
module Spree
  class BoletoDocsController < ApplicationController
    def create
      @order = Spree::Order.find_by_number(params[:number])
      @boleto = @order.boletos.new(:status => "issued", :amount => order.total)
      @boleto.process! @order.payment
      formato = Spree::Boleto::Configuration[:formato]

    end
    def show
      @boleto_doc = BoletoDoc.find(params[:id])
      @boleto = @boleto_doc.payload
      respond_to do |format|
        format.html
        format.pdf do
          formato = "pdf"
          headers['Content-Type']= PaymentMethod::BoletoMethod::FORMATS[formato]
          send_data @boleto.to(formato), :filename => "boleto_#{@boleto.banco}_#{@boleto_doc.id}.#{formato}", :disposition => "attachment", :type => PaymentMethod::BoletoMethod::FORMATS[formato]
        end
        format.image do
          formato = "jpg"
          headers['Content-Type']= PaymentMethod::BoletoMethod::FORMATS[formato]
          send_data @boleto.to(formato), :filename => "boleto_#{@boleto.banco}_#{@boleto_doc.id}.#{formato}", :disposition => 'inline', :type => PaymentMethod::BoletoMethod::FORMATS[formato]
        end
      end
    end
  end
end