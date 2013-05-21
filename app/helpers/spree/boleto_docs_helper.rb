module Spree
  module BoletoDocsHelper
    def default_due_date
      date = Date.today + Spree::Boleto::Configuration.preferences[:dias_vencimento]
      l(date)
    end
  end
end