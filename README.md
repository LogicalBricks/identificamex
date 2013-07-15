# Identificamex

Gema con validadores para los formatos de la Clave Única de Registro de Población (CURP) y el Registro Federal de Contribuyentes (RFC) utilizados en México.
Los validadores se integran con el mecanismo que implementa ActiveModel para el resto de validadores de Rails.

## Instalación

Agrega esta línea al archivo Gemfile de tu aplicación

    gem 'identificamex'

Y después ejecuta:

    $ bundle

O instálala por ti mismo de esta manera:

    $ gem install identificamex

## Uso

Agrega las validaciones de formato a los campos correspondientes.


```ruby
class Employee < ActiveRecor::Base
  validates :curp, presence: true, curp_format: true
  validates :rfc, rfc_format: true, allow_blank: true
end
```

## Contribución

1. Haz un fork de este repositorio
2. Crea tu rama (`git checkout -b my-new-feature`)
3. Haz commit de tus cambios (`git commit -am 'Add some feature'`)
4. Haz push a la rama (`git push origin my-new-feature`)
5. Crea un nuevo Pull Request
