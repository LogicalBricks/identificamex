require_relative 'mayusculas'

module Identificamex
  module Nombre

    # Clase base para normalizar las cadenas de nombres y apellidos. La clase
    # se encarga de convertir a mayúsculas las cadenas y recorre los nombres para
    # descartar los nombres ignorados.
    #
    # Los nombres ignorados deben ser provistos por las clases que hereden.
    class NormalizadorCadena

      include Mayusculas

      def initialize(nombre)
        @nombre = mayusculas(nombre)
      end

      def normalizar
        nombre_aceptado || primer_nombre
      end

      private

      def nombre_aceptado
        nombres.find{|nombre| no_ignorado?(nombre) } if nombres.count > 1
      end

      def no_ignorado?(nombre)
        !nombres_ignorados.member?(nombre)
      end

      def primer_nombre
        nombres.first
      end

      def nombres_ignorados
        raise NotImplementedError
      end

      def nombres
        @nombres ||= @nombre.split
      end

    end
  end
end
