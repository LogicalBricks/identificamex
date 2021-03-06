[![Build Status](https://travis-ci.org/LogicalBricks/identificamex.png)](https://travis-ci.org/LogicalBricks/identificamex)


# Identificamex

Gema con validadores para los formatos de la Clave Única de Registro de
Población (CURP) y el Registro Federal de Contribuyentes (RFC) utilizados en
México.

Los validadores se integran con el mecanismo que implementa ActiveModel
para el resto de validadores de Rails.

## Instalación

Agrega esta línea al archivo Gemfile de tu aplicación

```ruby
gem 'identificamex'
```

Y después ejecuta:

    $ bundle

O instálala por ti mismo de esta manera:

    $ gem install identificamex

## Uso

### Formato

Agrega las validaciones de formato a los campos correspondientes.

```ruby
class Employee < ActiveRecord::Base
  validates :curp, presence: true, curp_format: true
  validates :rfc, rfc_format: { force_homoclave: true }, allow_blank: true
end
```

### valid_rfc?

En el caso del RFC, es posible verificar no sólo el formato sino también el
contenido. Para esto, se debe utilizar el método `valid_rfc?`. Este método se
encuentra en el módulo `Identificamex::Methods` y no se agrega
automáticamente a la base de ActiveRecord o ActiveModel, por lo que es
necesario agregarlo manualmente.

```ruby
class Employee < ActiveRecord::Base

  include Identificamex::Methods

  def un_metodo
    valid_rfc? 'BAFJ701213SBA', nombre: 'Juan',
                                primer_apellido: 'Barrios',
                                segundo_apellido: 'Fernández',
                                fecha_nacimiento: Date.new(1970, 12, 13)
    # => true

    valid_rfc? 'APB830305QS6', razon_social: 'U.S. Ruber Mexicana, S.A.',
                               fecha_creacion: Date.new(1983, 03, 05)
    # => false
  end
end
```

NOTA: _Esta versión todavía no valida correctamente el RFC de personas
morales que incluyan números o caracteres especiales en su razón social.
Por ejemplo: 'Cyber @ SA de CV', 'Cooperativa 5 de mayo SC',
'Estudio Siglo XXI SA'. Es una funcionalidad que se piensa incluir
posteriormente, al igual que la generación de la CURP_

El método `valid_rfc?` es auxiliar y ha funcionado con los casos que he
probado, pero no hay garantía que funcione en todos los casos, así que debe
usarse con precaución. Si detectas algún caso en el que no funciona, agrega
un _issue_ para tratar de corregirlo.

## Contribución

1. Haz un fork de este repositorio
2. Crea tu rama (`git checkout -b my-new-feature`)
3. Haz commit de tus cambios (`git commit -am 'Add some feature'`)
4. Haz push a la rama (`git push origin my-new-feature`)
5. Crea un nuevo Pull Request
