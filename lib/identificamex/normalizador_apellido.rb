require_relative 'normalizador_cadena'

module Identificamex

  # Clase que hereda de `NormalizadorCadena` y define los nombres a ignorar
  # como `%w[DE LA DEL LOS]` que son los únicos que se ignoran para los
  # apellidos.
  #
  # Ejemplo:
  #
  #     NormalizadorApellido.new('De la Rosa').normalizar
  #     # = ROSA
  #
  #     NormalizadorApellido.new('Del Toro').normalizar
  #     # = TORO
  #
  #     NormalizadorApellido.new('Pérez').normalizar
  #     # = PEREZ
  class NormalizadorApellido < NormalizadorCadena

    private

    def nombres_ignorados
      %w[DE LA DEL LOS]
    end

  end
end
