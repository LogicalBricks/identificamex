module Identificamex
  module Mayusculas
    def mayusculas(str)
      return if str.nil?
      str
      .gsub(/[ÁÉÍÓÚÜáéíóúü]/, hash_vocales)
      .upcase
      .gsub(/ñ/, 'Ñ')
      .gsub(/,/, '')
      .gsub(/\./, '')
    end

    def hash_vocales
      @hash_vocales ||= {'á' => 'a',
                         'é' => 'e',
                         'í' => 'i',
                         'ó' => 'o',
                         'ú' => 'u',
                         'ü' => 'u',
                         'Á' => 'A',
                         'É' => 'E',
                         'Í' => 'I',
                         'Ó' => 'O',
                         'Ú' => 'U',
                         'Ü' => 'U'}
    end
  end
end
