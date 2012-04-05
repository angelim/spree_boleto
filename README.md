# Spree Boleto

Uma extensão do [Spree](http://spreecommerce.com) para permitir pagamentos utilizando boletos.

## Instalação

Adicione spree ao gemfile da sua aplicação, e também:

    gem "spree_boleto"

Rode a task de instalação:

    rails generate spree_boleto:install
	
## Configuração
	
Após feita a instalação e migração, acesse a administração do spree, vá em Configuração -> Métodos de Pagamento e adicione um novo método selecionando `Spree::PaymentMethod::BoletoMethod`.
    
## TODO


## Contribuindo

Caso queira contribuir, faça um fork desta gem no [github](https://github.com/angelim/spree_boleto), corriga o bug/ adicione a feature desejada e faça um merge request.

## Sobre

Desenvolvida por [Alexandre Angelim](mailto:angelim@angelim.com.br)
Baseado no desenvolvimento de: [Stefano Diem Benatti](mailto:stefano@heavenstudio.com.br)
