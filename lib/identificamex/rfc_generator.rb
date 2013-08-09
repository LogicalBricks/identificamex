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

    def initialize(params)
      @nombre_completo  = build_nombre_completo(params)
      @razon_social     = build_razon_social(params)
      @fecha_nacimiento = params[:fecha_nacimiento]
      @fecha_creacion   = params[:fecha_creacion]
    end

    def rfc
      @rfc ||= (siglas_rfc_base + siglas_homoclave)
    end

    #=====================
    private
    #=====================

    def build_nombre_completo(params)
      hash = params_for_nombre(params)
      NombreCompleto.new(hash) if hash.values.any?(&:present?)
    end

    def build_razon_social(params)
      RazonSocial.new(params[:razon_social]) if params[:razon_social].present?
    end

    def siglas_rfc_base
      rfc_base.siglas
    end

    def siglas_homoclave
      homoclave.siglas
    end

    def rfc_base
      return @rfc_base if @rfc_base
      nombre = @nombre_completo || @razon_social
      fecha = @fecha_nacimiento || @fecha_creacion
      @rfc_base = RfcBase.new(nombre: nombre, fecha_nacimiento: fecha)
    end

    def homoclave
      @homoclave ||= Homoclave.new(@rfc_base)
    end

    def params_for_nombre(params)
      accepted_keys = %i[nombre primer_apellido segundo_apellido]
      params.reject{|k, v| !(accepted_keys.member?(k)) }
    end
  end
end
