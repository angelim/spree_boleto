module Spree
  module Boleto
    class Config < Spree::Preferences::Configuration
      preference :parcelas, :integer
      preference :banco, :string
      preference :formato, :string
      preference :convenio, :string
      preference :moeda, :string
      preference :carteira, :string
      preference :variacao, :string
      preference :data_processamento, :string
      preference :dias_vencimento, :integer
      preference :quantidade, :integer
      preference :agencia, :string
      preference :conta_corrente, :string
      preference :cedente, :string
      preference :documento_cedente, :string
      preference :especie, :string
      preference :especie_documento, :string
      preference :codigo_servico, :string
      preference :instrucao1, :string
      preference :instrucao2, :string
      preference :instrucao3, :string
      preference :instrucao4, :string
      preference :instrucao5, :string
      preference :instrucao6, :string
      preference :instrucao7, :string
      preference :local_pagamento, :string
      preference :aceite, :string
    end
  end
end

