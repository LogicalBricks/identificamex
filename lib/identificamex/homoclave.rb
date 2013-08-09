module Identificamex
  class Homoclave

    def initialize(rfc_base)
      @rfc_base = rfc_base
    end

    def siglas
      homonimia + digito_verificador
    end

    #=================
    private
    #=================

    def homonimia
      @homonimia ||= generar_homonimia
    end

    def generar_homonimia
      suma = map_sequential_pair(numbers){|v1, v2| to_number(v1, v2) * to_number(v2)}.inject(:+)
      numero_tres_ultimos_digitos = suma.to_s[-3..-1].to_i
      cosiente = numero_tres_ultimos_digitos / 34
      residuo = numero_tres_ultimos_digitos % 34
      [clave_diferenciadora[cosiente], clave_diferenciadora[residuo]].join
    end

    def map_sequential_pair(str)
      size = str.size
      str.each_char.each_with_index.collect do |v, i|
        yield str[v], str[i + 1] if i + 1 <= size
      end
    end

    def to_number(*chars)
      [*chars].join.to_i
    end

    def numbers
      @numbers ||= generate_numbers
    end

    def generate_numbers
      @rfc_base.nombre_completo
      .each_char
      .map{|ch| tabla_conversiones[ch]}
      .unshift('0')
      .join
    end

    def digito_verificador
      residuo_digito_verificador(suma_letras_rfc(@rfc_base.siglas + homonimia))
    end

    def suma_letras_rfc(str)
      str = " " + str if str.length < 12
      str.each_char.each_with_index.inject(0) do |total, (ch, i)|
        total + (longitud_base - i) * tabla_digito_verificador[ch]
      end
    end

    def residuo_digito_verificador(total)
      residuo = total % modulo_base
      if residuo == 0
        '0'
      elsif residuo == 10 || (modulo_base - residuo) == 10
        'A'
      else
        (modulo_base - residuo).to_s
      end
    end

    def longitud_base
     @longitud_base ||= 13
    end

    def modulo_base
      longitud_base - 2
    end

    def tabla_conversiones
      return @tabla_conversiones if @tabla_conversiones
      @tabla_conversiones = {
        ' ' => '00',
        '0' => '00',
        '1' => '01',
        '2' => '02',
        '3' => '03',
        '4' => '04',
        '5' => '05',
        '6' => '06',
        '7' => '07',
        '8' => '08',
        '9' => '09',
        '&' => '10',
        'A' => '11',
        'B' => '12',
        'C' => '13',
        'D' => '14',
        'E' => '15',
        'F' => '16',
        'G' => '17',
        'H' => '18',
        'I' => '19',
        'J' => '21',
        'K' => '22',
        'L' => '23',
        'M' => '24',
        'N' => '25',
        'O' => '26',
        'P' => '27',
        'Q' => '28',
        'R' => '29',
        'S' => '32',
        'T' => '33',
        'U' => '34',
        'V' => '35',
        'W' => '36',
        'X' => '37',
        'Y' => '38',
        'Z' => '39',
        'Ñ' => '40',
      }
      @tabla_conversiones.default = '0'
      @tabla_conversiones
    end

    def clave_diferenciadora
      {
        0 => '1',
        1 => '2',
        2 => '3',
        3 => '4',
        4 => '5',
        5 => '6',
        6 => '7',
        7 => '8',
        8 => '9',
        9 => 'A',
        10 => 'B',
        11 => 'C',
        12 => 'D',
        13 => 'E',
        14 => 'F',
        15 => 'G',
        16 => 'H',
        17 => 'I',
        18 => 'J',
        19 => 'K',
        20 => 'L',
        21 => 'M',
        22 => 'N',
        23 => 'P',
        24 => 'Q',
        25 => 'R',
        26 => 'S',
        27 => 'T',
        28 => 'U',
        29 => 'V',
        30 => 'W',
        31 => 'X',
        32 => 'Y',
        33 => 'Z',
      }
    end

    def tabla_digito_verificador
      {
        '0'=> 0,
        '1'=> 1,
        '2'=> 2,
        '3'=> 3,
        '4'=> 4,
        '5'=> 5,
        '6'=> 6,
        '7'=> 7,
        '8'=> 8,
        '9'=> 9,
        'A'=> 10,
        'B'=> 11,
        'C'=> 12,
        'D'=> 13,
        'E'=> 14,
        'F'=> 15,
        'G'=> 16,
        'H'=> 17,
        'I'=> 18,
        'J'=> 19,
        'K'=> 20,
        'L'=> 21,
        'M'=> 22,
        'N'=> 23,
        '&'=> 24,
        'O'=> 25,
        'P'=> 26,
        'Q'=> 27,
        'R'=> 28,
        'S'=> 29,
        'T'=> 30,
        'U'=> 31,
        'V'=> 32,
        'W'=> 33,
        'X'=> 34,
        'Y'=> 35,
        'Z'=> 36,
        ' '=> 37,
        'Ñ'=> 38,
      }
    end
  end
end
