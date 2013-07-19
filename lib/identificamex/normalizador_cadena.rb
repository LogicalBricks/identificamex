require_relative 'mayusculas'

module Identificamex

  # Clase base para normalizar las cadenas de nombres y apellidos. La clase
  # se encarga de convertir a mayúsculas las cadenas y recorre los nombres para
  # descartar los nombres ignorados.
  #
  # Los nombres ignorados deben ser provistos por las clases que hereden.
  class NormalizadorCadena

    include Identificamex::Mayusculas

    def initialize(nombre)
      @nombre = mayusculas(nombre)
    end

    def normalizar
      if nombres.count > 1
        nombre_principal = nombres.find{ |n| !(nombres_ignorados.member?(n)) }
      end
      nombre_principal || nombres.first
    end

    private

    def nombres_ignorados
      raise NotImplementedError
    end

    def nombres
      @nombres ||= @nombre.split
    end

  end
end
