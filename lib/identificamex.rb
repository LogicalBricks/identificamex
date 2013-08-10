require 'active_model'
require_relative "identificamex/version"
require_relative "curp_format_validator"
require_relative "rfc_format_validator"
require_relative "identificamex/rfc/rfc_generator"

module Identificamex
  module Methods

    # Valida si un RFC está correctamente formado. Recibe como parámetros el
    # RFC a comparar y la razón social y fecha de creación (en caso de ser
    # persona moral) o el nombre, primer apellido, segundo apellido y fecha
    # de nacimiento (en caso de ser persona física).
    #
    # Ejemplos:
    #
    #     params = { razon_social: 'Sonora Industrial Azucarera, S. de R.L',
    #                fecha_creacion:  Date.new(1983, 03, 05) }
    #     valid_rfc? 'SIA8303054L5', params
    #     # => true
    #
    #     params = { nombre: 'Juan',
    #                primer_apellido:  'Barrios',
    #                segundo_apellido: 'Fernández',
    #                fecha_nacimiento:  Date.new(1970, 12, 13) }
    #     valid_rfc? 'BAFJ701213SBA', params
    #     # => true
    #
    def valid_rfc?(rfc, options)
      ::Identificamex::Rfc::RfcGenerator.new(options).rfc == rfc
    end
  end
end
