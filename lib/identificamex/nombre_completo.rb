require_relative 'normalizador_apellido'

module Identificamex
  class NombreCompleto
    include Mayusculas

    def initialize(params)
      @nombre                        = mayusculas(params[:nombre])
      @primer_apellido               = mayusculas(params[:primer_apellido])
      @segundo_apellido              = mayusculas(params[:segundo_apellido])
      @nombre_simplificado           = normalizar_nombre(@nombre)
      @primer_apellido_simplificado  = normalizar_apellido(@primer_apellido)
      @segundo_apellido_simplificado = normalizar_apellido(@segundo_apellido)
    end

    def siglas
      @siglas ||= PalabraInconveniente.convertir(extraer_siglas)
    end

    def to_s
      "#{@primer_apellido} #{@segundo_apellido} #{@nombre}"
    end

    #=====================
    private
    #=====================

    def normalizar_nombre(nombre)
      NormalizadorNombre.new(nombre).normalizar if nombre
    end

    def normalizar_apellido(apellido)
      NormalizadorApellido.new(apellido).normalizar if apellido
    end

    def extraer_siglas
      if siglas_apellidos_completa?
        siglas_apellidos + primera_letra_nombre
      else
        siglas_apellidos + primeras_dos_letras_nombre
      end
    end

    def siglas_apellidos
      @siglas_apellidos ||= generar_siglas_apellidos
    end

    def siglas_apellidos_completa?
      siglas_apellidos.length == 3
    end

    def generar_siglas_apellidos
      return @segundo_apellido_simplificado[0, 2] if sin_primer_apellido?
      return @primer_apellido_simplificado[0, 2] if sin_segundo_apellido?
      primera_letra_primer_apellido +
        primera_vocal_interna_primer_apellido.to_s +
        primera_letra_segundo_apellido
    end

    def sin_primer_apellido?
      @primer_apellido_simplificado.nil?
    end

    def sin_segundo_apellido?
      @segundo_apellido_simplificado.nil?
    end

    def primera_letra_primer_apellido
      @primer_apellido_simplificado[0] if @primer_apellido_simplificado.present?
    end

    def primera_vocal_interna_primer_apellido
      return unless @primer_apellido_simplificado.present?
      apellido = @primer_apellido_simplificado[1..-1]
      posicion_primera_vocal = apellido =~ /[AEIOU]/
      apellido[posicion_primera_vocal] if posicion_primera_vocal
    end

    def primera_letra_segundo_apellido
      @segundo_apellido_simplificado[0] if @segundo_apellido_simplificado.present?
    end

    def primera_letra_nombre
      @nombre_simplificado[0] if @nombre_simplificado.present?
    end

    def primeras_dos_letras_nombre
      @nombre_simplificado[0, 2] if @nombre_simplificado.present?
    end

  end
end
