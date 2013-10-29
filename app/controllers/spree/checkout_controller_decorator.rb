Spree::CheckoutController.class_eval do
  alias_method :original_object_params, :object_params
  def object_params
    if @order.payment?
      return original_object_params unless params[:order][:payments_attributes].first[:payment_method_id].to_i == Spree::Order.boleto_payment_method.id
      instalments = params[:order][:instalments].to_i
      instalment_amount = (@order.total/instalments.to_i)
      payment_method_id = params[:order][:payments_attributes].first[:payment_method_id]
      params[:order][:payments_attributes] = []
      acc_amount = 0.to_f
      instalments.times do |index|
        amount = (index+1) == instalments ? (@order.total-acc_amount).to_f : instalment_amount
        amount = amount.round(2)
        acc_amount += amount
        params[:order][:payments_attributes] << {
          :payment_method_id => payment_method_id, 
          :amount => amount.to_f, 
          :state => "pending",
          :source_attributes => {
            :order_id => @order.id,
            :due_date => Date.today + index.month + Spree::Boleto::Configuration.preferences[:dias_vencimento],
            :amount => amount.to_f,
            :status => "pending"
          }
        }
      end
    end
    params[:order]
  end
end

