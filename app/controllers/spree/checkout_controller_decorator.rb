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
          :amount => amount, 
          :state => "pending",
          :source_attributes => {
            :order_id => @order.id,
            :due_date => Date.today + index.month + Spree::Boleto::Configuration.preferences[:dias_vencimento],
            :amount => amount,
            :status => "pending"
          }
        }
      end
    end
    params[:order]
  end
end

Spree::Admin::PaymentsController.class_eval do
  def new
    @payment = @order.payments.build(:payment_method => @order.payment.payment_method)
    respond_with(@payment)
  end
end

# Spree::AdminPaymentsController.class_eval do
#   alias_method :original_object_params, :object_params
#   def object_params
#     if @order.payment?
#       return original_object_params unless params[:order][:payments_attributes].first[:payment_method_id].to_i == Spree::Order.boleto_payment_method.id
#       params[:order][:payments_attributes] = []
#       params[:payment] = {
#         :payment_method_id => @order.payment_method_id, 
#         :amount => params[:amount], 
#         :state => "pending",
#         :source_attributes => {
#           :order_id => @order.id,
#           :due_date => Date.parse(params[:due_date]),
#           :amount => params[:amount],
#           :status => "pending"
#         }
#       }
#     end
#     params[:payment]
#   end
# end
# 
# def create
#   @payment = @order.payments.build(object_params)
#   if @payment.payment_method.is_a?(Spree::Gateway) && @payment.payment_method.payment_profiles_supported? && params[:card].present? and params[:card] != 'new'
#     @payment.source = Creditcard.find_by_id(params[:card])
#   end
# 
#   begin
#     unless @payment.save
#       respond_with(@payment) { |format| format.html { redirect_to admin_order_payments_path(@order) } }
#       return
#     end
# 
#     if @order.completed?
#       @payment.process!
#       flash.notice = flash_message_for(@payment, :successfully_created)
# 
#       respond_with(@payment) { |format| format.html { redirect_to admin_order_payments_path(@order) } }
#     else
#       #This is the first payment (admin created order)
#       until @order.completed?
#         @order.next!
#       end
#       flash.notice = t(:new_order_completed)
#       respond_with(@payment) { |format| format.html { redirect_to admin_order_url(@order) } }
#     end
# 
#   rescue Spree::Core::GatewayError => e
#     flash[:error] = "#{e.message}"
#     respond_with(@payment) { |format| format.html { redirect_to new_admin_payment_path(@order) } }
#   end
# end
# 
# 
# def object_params
#   if params[:payment] and params[:payment_source] and source_params = params.delete(:payment_source)[params[:payment][:payment_method_id]]
#     params[:payment][:source_attributes] = source_params
#   end
#   params[:payment]
# end
