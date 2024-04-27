# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'cash_register_amenitiz'
  spec.version       = '0.1.0'
  spec.authors       = ['Daniel Vilches']
  spec.email         = ['danielvilches98@gmail.com']
  spec.summary       = 'A simple cash register CLI application'
  spec.description   = 'A command-line application for managing a cash register with pricing rules'
  spec.homepage      = 'https://github.com/muvildan'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 3.3.1'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'ruby-lsp'
end
