Deface::Override.new(
  virtual_path: "spree/shared/_order_details",
  name: "boleto_replace_payment_info",
  insert_bottom: ".payment-info",
  partial: "spree/checkout/payment/boleto_order_details"
)