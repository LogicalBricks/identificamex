require_relative 'mayusculas'

module Identificamex
  module Nombre

    # Clase base para normalizar las cadenas de nombres y apellidos. La clase
    # se encarga de convertir a mayúsculas las cadenas y recorre los nombres
    # para descartar los nombres ignorados.
    #
    # Los nombres ignorados deben ser provistos por las clases que hereden.
    # Para nombres, se ignoran los siguientes: `%w[JOSE MARIA DE LA DEL LOS]`.
    #
    # Ejemplo:
    #
    #     NormalizadorNombre.new('María del Carmen').normalizar
    #     # => CARMEN
    #
    #     NormalizadorNombre.new('José Mario').normalizar
    #     # => MARIO
    #
    #     NormalizadorNombre.new('María de los Ángeles').normalizar
    #     # => ANGELES
    #
    #     NormalizadorNombre.new('José de Jesús').normalizar
    #     # => JESUS
    #
    #     NormalizadorNombre.new('María').normalizar
    #     # => MARIA
    #
    #     NormalizadorNombre.new('José Mario').normalizar
    #     # => MARIO
    #
    #     NormalizadorNombre.new('José').normalizar
    #     # => JOSE
    class NormalizadorNombre

      include Mayusculas

      def initialize(nombre)
        @nombre = mayusculas(nombre)
      end

      def normalizar
        nombre_aceptado || primer_nombre
      end

      private

      def nombre_aceptado
        (nombres - nombres_ignorados).first
      end

      def primer_nombre
        nombres.first
      end

      def nombres_ignorados
        %w[JOSE MARIA DE LA DEL LOS]
      end

      def nombres
        @nombres ||= @nombre.split
      end

    end
  end
end
