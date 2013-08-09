require_relative '../nombre/nombre_completo'
require_relative '../nombre/razon_social'
require_relative 'rfc_base'
require_relative 'homoclave'

module Identificamex
  module Rfc

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
        @rfc ||= generar_rfc
      end

      #=====================
      private
      #=====================

      def generar_rfc
        rfc_base.siglas + homoclave.siglas
      end

      def build_nombre_completo(params)
        hash = params_for_nombre(params)
        if hash.values.any?(&:present?)
          ::Identificamex::Nombre::NombreCompleto.new(hash)
        end
      end

      def build_razon_social(params)
        if params[:razon_social].present?
          ::Identificamex::Nombre::RazonSocial.new(params[:razon_social])
        end
      end

      def rfc_base
        @rfc_base ||= generar_rfc_base
      end

      def generar_rfc_base
        RfcBase.new(
          nombre:           @nombre_completo  || @razon_social,
          fecha_nacimiento: @fecha_nacimiento || @fecha_creacion
        )
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
end
