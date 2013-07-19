require_relative 'palabra_inconveniente'

module Identificamex

  # Clase responsable de generar un RFC. Recibe el rfc y un `hash` con los
  # valores del nombre, primer apellido, segundo apellido y fecha de nacimiento
  # en caso de ser una persona física, o bien, razón social y fecha de creación
  # en caso de ser una persona moral.
  #
  # Ejemplos:
  #
  #     validator = RfcGenerator.new(nombre:           'Juan',
  #                                  primer_apellido:  'Barrios',
  #                                  segundo_apellido: 'Fernández',
  #                                  fecha_nacimiento: Date.new(1970, 12, 13))
  #     validator.rfc
  #     # => 'BAFJ701213'
  #
  #     validator = RfcGenerator.new(nombre:           'Juan',
  #                                  primer_apellido:  'Martínez',
  #                                  segundo_apellido: nil,
  #                                  fecha_nacimiento: Date.new(1970, 12, 13))
  #     validator.rfc
  #     # => 'MAJU701213'
  class RfcGenerator

    def initialize(options)
      @nombre_completo  = NombreCompleto.new(options_for_nombre(options))
      @fecha_nacimiento = options[:fecha_nacimiento]
      @razon_social     = options[:razon_social]
      @fecha_creacion   = options[:fecha_creacion]
    end

    def rfc
      @rfc ||= rfc_generado
    end

    #=====================
    private
    #=====================

    def rfc_generado
      @razon_social ? rfc_persona_moral : rfc_persona_fisica
    end

    def rfc_persona_moral
      tres_letras_de_razon_social + fecha_creacion
    end

    def rfc_persona_fisica
      convertir_palabra_inconveniente(cuatro_letras_de_nombre) + fecha_nacimiento
    end

    def cuatro_letras_de_nombre
      @nombre_completo.siglas
    end

    def fecha_nacimiento
      fecha_string(@fecha_nacimiento.to_date)
    end

    def fecha_creacion
      fecha_string(@fecha_creacion.to_date)
    end

    def fecha_string(fecha)
      fecha.strftime('%y%m%d')
    end

    def convertir_palabra_inconveniente(palabra)
      PalabraInconveniente.convertir(palabra)
    end

    def options_for_nombre(options)
      accepted_keys = %i[nombre primer_apellido segundo_apellido]
      options.reject{|k, v| !(accepted_keys.member?(k)) }
    end
  end
end
