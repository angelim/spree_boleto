module Brcobranca
  class Configuration
    attr_accessor :external_encoding
  end
end
Brcobranca.setup do |config|
  config.external_encoding = 'ascii-8bit'
  config.resolucao = 300
end
RGhost::Config::GS[:external_encoding] = 'ascii-8bit'
RGhost::Config::GS[:path] = `which gs`.strip