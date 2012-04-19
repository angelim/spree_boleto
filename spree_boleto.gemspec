# encoding: UTF-8
version = File.read(File.expand_path("../GEM_VERSION",__FILE__)).strip

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_boleto'
  s.version     = version
  s.summary     = 'Spree extension for integration with Boleto'
  s.description = 'Spree extension for integration with Boleto payment. Based on spree_pag_seguro and brcobranca gems'
  s.required_ruby_version = '>= 1.9.2'

  s.author            = 'Alexandre Angelim'
  s.email             = 'angelim@angelim.com.br'
  s.homepage          = 'http://github.com/angelim/spree_boleto'

  s.files        = Dir['CHANGELOG', 'README.md', 'LICENSE', 'lib/**/*', 'app/**/*', 'config/**/*', 'db/**/*', 'spec/**/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core'
  s.add_dependency 'brcobranca'

  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.7'
  s.add_development_dependency 'sqlite3'
end
