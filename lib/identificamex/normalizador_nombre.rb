require_relative 'normalizador_cadena'

module Identificamex

  # Clase que hereda de `NormalizadorCadena` y define los nombres a ignorar
  # como `%w[JOSE MARIA DE LA DEL LOS]` que son los que se ignoran para los
  # nombres.
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
  class NormalizadorNombre < NormalizadorCadena

    private

    def nombres_ignorados
      %w[JOSE MARIA DE LA DEL LOS]
    end

  end
end
