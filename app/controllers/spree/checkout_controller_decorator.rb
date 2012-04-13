Spree::CheckoutController.class_eval do
  alias_method :original_object_params, :object_params
  def object_params
    if @order.payment?
      return original_object_params unless params[:order][:payments_attributes].first[:payment_method_id].to_i == Spree::Order.boleto_payment_method.id
      instalments = params[:order][:instalments]
      payment_method_id = params[:order][:payments_attributes].first[:payment_method_id]
      params[:order][:payments_attributes] = []
      instalments.to_i.times do |index|
        params[:order][:payments_attributes] << {
          :payment_method_id => payment_method_id, 
          :amount => @order.total/instalments.to_i, 
          :state => "pending",
          :source_attributes => {
            :order_id => @order.id,
            :due_date => Date.today + index.month + Spree::Boleto::Configuration.preferences[:dias_vencimento],
            :amount => @order.total/instalments.to_i,
            :status => "pending"
          }
        }
      end
    end
    params[:order]
  end
end
