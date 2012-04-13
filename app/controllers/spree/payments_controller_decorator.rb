Spree::Admin::PaymentsController.class_eval do
  before_filter :copy_amount, :only => :create
  def copy_amount
    method = params[:payment][:payment_method_id]
    params[:payment_source][method][:amount] = params[:payment][:amount]
  end
end