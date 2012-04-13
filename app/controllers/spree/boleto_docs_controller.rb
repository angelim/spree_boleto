# encoding:utf-8
module Spree
  class BoletoDocsController < Spree::BaseController
    before_filter :check_authorization
    before_filter :load_order
    respond_to :html, :image, :pdf

    layout "spree/layouts/print_layout"
    
    def index
      @boletos = []
      @order.boleto_docs.pending.each do |boleto_doc|
        @boletos << boleto_doc.payload
      end
      respond_to do |format|
        format.html
        format.pdf do
          formato = "pdf"
          headers['Content-Type']= PaymentMethod::BoletoMethod::FORMATS[formato]
          send_data Brcobranca::Boleto::Base.lote(@boletos), :filename => "boletos_#{@order.number}.#{formato}", :disposition => "attachment", :type => PaymentMethod::BoletoMethod::FORMATS[formato]
        end
      end
    end
    
    def show
      @boleto_doc = @order.boleto_docs.find(params[:id])
      @boleto = @boleto_doc.payload
      respond_to do |format|
        format.html
        format.pdf do
          formato = "pdf"
          headers['Content-Type']= PaymentMethod::BoletoMethod::FORMATS[formato]
          send_data @boleto.to(formato), :filename => "boleto_#{@boleto_doc.order.number}_#{@boleto_doc.id}.#{formato}", :disposition => "attachment", :type => PaymentMethod::BoletoMethod::FORMATS[formato]
        end
        format.image do
          formato = "jpg"
          headers['Content-Type']= PaymentMethod::BoletoMethod::FORMATS[formato]
          send_data @boleto.to(formato), :filename => "boleto_#{@boleto_doc.order.number}_#{@boleto_doc.id}.#{formato}", :disposition => 'inline', :type => PaymentMethod::BoletoMethod::FORMATS[formato]
        end
      end
    end
    
    private 
    def check_authorization
      session[:access_token] ||= params[:token]
      order = current_order || Spree::Order.find_by_number(params[:order_id])

      if order
        authorize! :edit, order, session[:access_token]
      else
        authorize! :create, Spree::Order
      end
    end
    
    def load_order
      @order = Spree::Order.find_by_number(params[:order_id])
    end
  end
end