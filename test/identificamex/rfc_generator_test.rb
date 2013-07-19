require_relative '../test_helper'
require_relative '../../lib/identificamex/rfc_generator'
require 'date'

module Identificamex
  describe RfcGenerator do
    describe 'persona física' do
      it 'accepts valid data (nombres y apellidos completos)' do
        validator = RfcGenerator.new(nombre:           'Juan',
                                     primer_apellido:  'Barrios',
                                     segundo_apellido: 'Fernández',
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        validator.rfc.must_equal 'BAFJ701213'
      end

      it 'accepts valid data (nombres y apellidos completos, primer apellido empieza con vocal)' do
        validator = RfcGenerator.new(nombre:           'Juan',
                                     primer_apellido:  'Antonio',
                                     segundo_apellido: 'Fernández',
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        validator.rfc.must_equal 'AOFJ701213'
      end

      it 'accepts valid data (letra compuesta en nombres o apellidos)' do
        validator = RfcGenerator.new(nombre:           'Charles',
                                     primer_apellido:  'Chávez',
                                     segundo_apellido: 'Llamas',
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        validator.rfc.must_equal 'CALC701213'
      end

      it 'accepts valid data (apellido parterno de dos letras)' do
        validator = RfcGenerator.new(nombre:           'Álvaro',
                                     primer_apellido:  'de la O',
                                     segundo_apellido: 'Lozano',
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        validator.rfc.must_equal 'OLAL701213'

        validator = RfcGenerator.new(nombre:           'Ernesto',
                                     primer_apellido:  'Ek',
                                     segundo_apellido: 'Rivera',
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        validator.rfc.must_equal 'ERER701213'
      end

      it 'accepts valid data (con solo primer apellido)' do
        validator = RfcGenerator.new(nombre:           'Gerarda',
                                     primer_apellido:   nil,
                                     segundo_apellido: 'Zafra',
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        validator.rfc.must_equal 'ZAGE701213'
      end

      it 'accepts valid data (con solo segundo apellido)' do
        validator = RfcGenerator.new(nombre:           'Juan',
                                     primer_apellido:  'Martínez',
                                     segundo_apellido:  nil,
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        validator.rfc.must_equal 'MAJU701213'
      end

      it 'accepts valid data (caracteres especiales)' do
        validator = RfcGenerator.new(nombre:           'Roberto',
                                     primer_apellido:  "O'farril",
                                     segundo_apellido: 'Carballo',
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        validator.rfc.must_equal 'OACR701213'

        validator = RfcGenerator.new(nombre:           'Rubén',
                                     primer_apellido:  "D'angelo",
                                     segundo_apellido: 'Fargo',
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        validator.rfc.must_equal 'DAFR701213'

        validator = RfcGenerator.new(nombre:           'Luz Ma.',
                                     primer_apellido:  'Fernández',
                                     segundo_apellido: 'Juárez',
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        validator.rfc.must_equal 'FEJL701213'
      end

      it 'accepts valid data (convierte palabras inconvenientes)' do
        validator = RfcGenerator.new(nombre:           'Omar',
                                     primer_apellido:  'Pérez',
                                     segundo_apellido: 'Domínguez',
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        validator.rfc.must_equal 'PEDX701213'
      end
    end
  end
end
