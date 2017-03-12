# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'identificamex/version'

Gem::Specification.new do |spec|
  spec.name          = 'identificamex'
  spec.version       = Identificamex::VERSION
  spec.authors       = ['Azarel Doroteo Pacheco']
  spec.email         = ['azarel.doroteo@logicalbricks.com']
  spec.description   = %q{Validadores para los formatos de CURP y RFC}
  spec.summary       = %q{Validadores sencillos para los formatos de la Clave Única de Registro de Población (CURP) y el Registro Federal de Contribuyentes (RFC) utilizados en México}
  spec.homepage      = 'https://github.com/LogicalBricks/identificamex'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.14.6'
  spec.add_development_dependency 'rake'

  spec.add_dependency 'activemodel'
end
