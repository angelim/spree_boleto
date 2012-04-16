Spree::Address.class_eval do
  # @todo Move this to a real decorator
  def full_address
    full = ""
    full << address1
    full << ", #{number}" if number.present?
    full << ", #{address2}" if address2.present?
    full << " - #{neighborhood}" if neighborhood.present?
    full << " - #{zipcode}" if zipcode.present?
    full << " - #{city}" if city.present?
    full << "/#{state.abbr}" if state.present?
    full
  end
end