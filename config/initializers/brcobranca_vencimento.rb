# @author Kivanio Barbosa
module Brcobranca
  module Boleto
    class Base
      attr_accessor :vencimento_fixo
      def data_vencimento
        return vencimento_fixo if vencimento_fixo.present?
        super
      end
    end
  end
end