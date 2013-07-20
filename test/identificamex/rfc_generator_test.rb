require_relative '../test_helper'
require_relative '../../lib/identificamex/rfc_generator'
require 'date'

module Identificamex
  describe RfcGenerator do
    describe 'persona física' do
      it 'nombre, primer apellido inicia con consonante, segundo apellido y fecha de nacimiento' do
        generator = RfcGenerator.new(nombre:           'Juan',
                                     primer_apellido:  'Barrios',
                                     segundo_apellido: 'Fernández',
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        generator.rfc.must_equal 'BAFJ701213'
      end

      it 'nombre, primer apellido inicia con vocal, segundo apellido y fecha de nacimiento' do
        generator = RfcGenerator.new(nombre:           'Juan',
                                     primer_apellido:  'Antonio',
                                     segundo_apellido: 'Fernández',
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        generator.rfc.must_equal 'AOFJ701213'
      end

      it 'nombre, primer apellido inicia con letra compuesta, segundo apellido y fecha de nacimiento' do
        generator = RfcGenerator.new(nombre:           'Charles',
                                     primer_apellido:  'Chávez',
                                     segundo_apellido: 'Llamas',
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        generator.rfc.must_equal 'CALC701213'
      end

      it 'nombre, primer apellido sin vocal interna, segundo apellido y fecha de nacimiento' do
        generator = RfcGenerator.new(nombre:           'Álvaro',
                                     primer_apellido:  'de la O',
                                     segundo_apellido: 'Lozano',
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        generator.rfc.must_equal 'OLAL701213'

        generator = RfcGenerator.new(nombre:           'Ernesto',
                                     primer_apellido:  'Ek',
                                     segundo_apellido: 'Rivera',
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        generator.rfc.must_equal 'ERER701213'
      end

      it 'nombre, sin primer apellido, segundo apellido y fecha de nacimiento' do
        generator = RfcGenerator.new(nombre:           'Gerarda',
                                     primer_apellido:   nil,
                                     segundo_apellido: 'Zafra',
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        generator.rfc.must_equal 'ZAGE701213'
      end

      it 'nombre, primer apellido, sin segundo apellido, fecha de nacimiento' do
        generator = RfcGenerator.new(nombre:           'Juan',
                                     primer_apellido:  'Martínez',
                                     segundo_apellido:  nil,
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        generator.rfc.must_equal 'MAJU701213'
      end

      it 'Nombre, primer apellido con caracter especial, segundo apellido y fecha de ncimiento' do
        generator = RfcGenerator.new(nombre:           'Roberto',
                                     primer_apellido:  "O'farril",
                                     segundo_apellido: 'Carballo',
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        generator.rfc.must_equal 'OACR701213'

        generator = RfcGenerator.new(nombre:           'Rubén',
                                     primer_apellido:  "D'angelo",
                                     segundo_apellido: 'Fargo',
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        generator.rfc.must_equal 'DAFR701213'

        generator = RfcGenerator.new(nombre:           'Luz Ma.',
                                     primer_apellido:  'Fernández',
                                     segundo_apellido: 'Juárez',
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        generator.rfc.must_equal 'FEJL701213'
      end

      it 'palabra inapropiada' do
        generator = RfcGenerator.new(nombre:           'Omar',
                                     primer_apellido:  'Pérez',
                                     segundo_apellido: 'Domínguez',
                                     fecha_nacimiento:  Date.new(1970, 12, 13))
        generator.rfc.must_equal 'PEDX701213'
      end
    end #Describe persona fisica

    describe 'Persona moral' do
      it 'takes the first a letter of three words' do
        generator = RfcGenerator.new(razon_social: 'Sonora Industrial Azucarera, S. de R.L',
                                     fecha_creacion: Date.new(1983,03,05))
        generator.rfc.must_equal 'SIA830305'
      end

      it 'takes the first a letter of three words skipping invalid words' do
        generator = RfcGenerator.new(razon_social: 'Artículos de piel y Baúles, S. de R. L.',
                                     fecha_creacion: Date.new(1983,03,05))
        generator.rfc.must_equal 'APB830305'
      end

      it 'ignores the second letter of the compound letters' do
        generator = RfcGenerator.new(razon_social: 'Champion Mexicana de Bujías, S.A.',
                                     fecha_creacion: Date.new(1983,03,05))
        generator.rfc.must_equal 'CMB830305'
      end

      it 'ignores the dot and takes single letters' do
        generator = RfcGenerator.new(razon_social: 'U.S. Ruber Mexicana, S.A.',
                                     fecha_creacion: Date.new(1983,03,05))
        generator.rfc.must_equal 'USR830305'
      end

      it 'takes the first letter from first word and two letters from second word' do
        generator = RfcGenerator.new(razon_social: 'Aceros Ecatepec, S.A.',
                                     fecha_creacion: Date.new(1983,03,05))
        generator.rfc.must_equal 'AEC830305'
      end

      it 'takes the three letters from first word' do
        generator = RfcGenerator.new(razon_social: 'Arsuyama, S.A.',
                                     fecha_creacion: Date.new(1983,03,05))
        generator.rfc.must_equal 'ARS830305'
      end

      it 'adds xx when the company name has one letter' do
        generator = RfcGenerator.new(razon_social: 'Z, S.A.',
                                     fecha_creacion: Date.new(1983,03,05))
        generator.rfc.must_equal 'ZXX830305'
      end

      it 'ignores invalid words (los, de)' do
        generator = RfcGenerator.new(razon_social: 'Los Viajes Internacionales de Marco Polo, S.A.',
                                     fecha_creacion: Date.new(1983,03,05))
        generator.rfc.must_equal 'VIM830305'
      end

      it 'ignores invalid words (y, para)' do
        generator = RfcGenerator.new(razon_social: 'Artículos y Accesorios para Automóviles, S.A.',
                                     fecha_creacion: Date.new(1983,03,05))
        generator.rfc.must_equal 'AAA830305'
      end

      it 'ignores invalid words (el)' do
        generator = RfcGenerator.new(razon_social: 'El abastecedor Ferretero, S.A.',
                                     fecha_creacion: Date.new(1983,03,05))
        generator.rfc.must_equal 'AFE830305'
      end

      it 'ignores (compañia)' do
        generator = RfcGenerator.new(razon_social: 'Compañía Periodística Nacional, S.A.',
                                     fecha_creacion: Date.new(1983,03,05))
        generator.rfc.must_equal 'PNA830305'
      end

      it 'ignores (cia.)' do
        generator = RfcGenerator.new(razon_social: 'Pimienta Hnos. y Cía., S.A.',
                                     fecha_creacion: Date.new(1983,03,05))
        generator.rfc.must_equal 'PHN830305'
      end
    end

  end
end
