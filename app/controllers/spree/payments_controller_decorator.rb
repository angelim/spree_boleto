Spree::Admin::PaymentsController.class_eval do
  before_filter :copy_amount, :only => :create
  def copy_amount
    method = params[:payment][:payment_method_id]
    payment_method = Spree::PaymentMethod.find method
    if payment_method.is_a? Spree::PaymentMethod::BoletoMethod
      params[:payment_source][method][:amount] = params[:payment][:amount]
    end
  end
end