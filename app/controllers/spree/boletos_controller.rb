module Spree
  class BoletosController < ApplicationController
    def create
      @order = Spree::Order.find_by_number(params[:number])
      @boleto = @order.boletos.new(:status => "issued", :amount => order.total)
      @boleto.process! @order.payment
    end
    def show
      
    end
  end
end

# validates_presence_of :due_date, :order_id, :status, :amount, :payload, :document_number