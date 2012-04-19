module Brcobranca
  module Boleto
    module Template
      module Rghost
        def modelo_generico_rodape(doc, boleto)
          #INICIO Segunda parte do BOLETO BB
          # LOGOTIPO do BANCO
          doc.image(boleto.logotipo, :x => '0.5 cm', :y => '16.8 cm', :zoom => 80)
          doc.moveto :x => '5.2 cm' , :y => '16.8 cm'
          doc.show "#{boleto.banco}-#{boleto.banco_dv}", :tag => :grande
          doc.moveto :x => '7.5 cm' , :y => '16.8 cm'
          doc.show boleto.codigo_barras.linha_digitavel, :tag => :grande
          doc.moveto :x => '0.7 cm' , :y => '16 cm'
          doc.show boleto.local_pagamento
          doc.moveto :x => '16.5 cm' , :y => '16 cm'
          doc.show boleto.data_vencimento.to_s_br if boleto.data_vencimento
          doc.moveto :x => '0.7 cm' , :y => '15.2 cm'
          doc.show "#{boleto.cedente}   CNPJ/CPF:#{boleto.documento_cedente.formata_documento}"
          doc.moveto :x => '16.5 cm' , :y => '15.2 cm'
          doc.show boleto.agencia_conta_boleto
          doc.moveto :x => '0.7 cm' , :y => '14.4 cm'
          doc.show boleto.data_documento.to_s_br if boleto.data_documento
          doc.moveto :x => '4.2 cm' , :y => '14.4 cm'
          doc.show boleto.numero_documento
          doc.moveto :x => '10 cm' , :y => '14.4 cm'
          doc.show boleto.especie_documento
          doc.moveto :x => '11.7 cm' , :y => '14.4 cm'
          doc.show boleto.aceite
          doc.moveto :x => '13 cm' , :y => '14.4 cm'
          doc.show boleto.data_processamento.to_s_br if boleto.data_processamento
          doc.moveto :x => '16.5 cm' , :y => '14.4 cm'
          doc.show boleto.nosso_numero_boleto
          doc.moveto :x => '4.4 cm' , :y => '13.5 cm'
          doc.show boleto.carteira
          doc.moveto :x => '6.4 cm' , :y => '13.5 cm'
          doc.show boleto.especie
          doc.moveto :x => '8 cm' , :y => '13.5 cm'
          doc.show boleto.quantidade
          doc.moveto :x => '11 cm' , :y => '13.5 cm'
          doc.show boleto.valor.to_currency
          doc.moveto :x => '16.5 cm' , :y => '13.5 cm'
          doc.show boleto.valor_documento.to_currency
          doc.moveto :x => '0.7 cm' , :y => '12.7 cm'
          doc.show boleto.instrucao1
          doc.moveto :x => '0.7 cm' , :y => '12.3 cm'
          doc.show boleto.instrucao2
          doc.moveto :x => '0.7 cm' , :y => '11.9 cm'
          doc.show boleto.instrucao3
          doc.moveto :x => '0.7 cm' , :y => '11.5 cm'
          doc.show boleto.instrucao4
          doc.moveto :x => '0.7 cm' , :y => '11.1 cm'
          doc.show boleto.instrucao5
          doc.moveto :x => '0.7 cm' , :y => '10.7 cm'
          doc.show boleto.instrucao6
          doc.moveto :x => '1.2 cm' , :y => '8.8 cm'
          doc.show "#{boleto.sacado} - #{boleto.sacado_documento.formata_documento}" if boleto.sacado && boleto.sacado_documento
          doc.moveto :x => '1.2 cm' , :y => '8.4 cm'
          doc.show "#{boleto.sacado_endereco}"
          #FIM Segunda parte do BOLETO
        end
      end
    end
  end
end
