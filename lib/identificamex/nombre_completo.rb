require_relative 'normalizador_apellido'

module Identificamex
  class NombreCompleto

    def initialize(params)
      @nombre           = normalizar_nombre(params[:nombre])
      @primer_apellido  = normalizar_apellido(params[:primer_apellido])
      @segundo_apellido = normalizar_apellido(params[:segundo_apellido])
    end

    def siglas
      if siglas_apellidos_completa?
        siglas_apellidos + primera_letra_nombre
      else
        siglas_apellidos + primeras_dos_letras_nombre
      end
    end

    def to_s
      "#{@primer_apellido} #{@segundo_apellido} #{@nombre}"
    end

    #=====================
    private
    #=====================

    def primera_letra_primer_apellido
      @primer_apellido[0] if @primer_apellido.present?
    end

    def primera_vocal_interna_primer_apellido
      return unless @primer_apellido.present?
      apellido = @primer_apellido[1..-1]
      posicion_primera_vocal = apellido =~ /[AEIOU]/
      apellido[posicion_primera_vocal] if posicion_primera_vocal
    end

    def primera_letra_segundo_apellido
      @segundo_apellido[0] if @segundo_apellido.present?
    end

    def primera_letra_nombre
      @nombre[0] if @nombre.present?
    end

    def primeras_dos_letras_nombre
      @nombre[0, 2] if @nombre.present?
    end

    def siglas_apellidos
      @siglas_apellidos ||= generar_siglas_apellidos
    end

    def siglas_apellidos_completa?
      siglas_apellidos.length == 3
    end

    def normalizar_nombre(nombre)
      NormalizadorNombre.new(nombre).normalizar if nombre
    end

    def normalizar_apellido(apellido)
      NormalizadorApellido.new(apellido).normalizar if apellido
    end

    def generar_siglas_apellidos
      return @segundo_apellido[0, 2] if @primer_apellido.nil?
      return @primer_apellido[0, 2] if @segundo_apellido.nil?
      primera_letra_primer_apellido +
        primera_vocal_interna_primer_apellido.to_s +
        primera_letra_segundo_apellido
    end
  end
end
