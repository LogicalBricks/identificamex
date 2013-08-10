require_relative '../../test_helper'
require_relative '../../../lib/identificamex/rfc/rfc_generator'
require 'date'

module Identificamex
  module Rfc

    describe RfcGenerator do
      describe 'persona física' do
        it 'nombre, primer apellido inicia con consonante, segundo apellido y fecha de nacimiento' do
          generator = RfcGenerator.new(nombre:           'Juan',
                                       primer_apellido:  'Barrios',
                                       segundo_apellido: 'Fernández',
                                       fecha_nacimiento:  Date.new(1970, 12, 13))
          generator.rfc.must_equal 'BAFJ701213SBA'
        end

        it 'nombre, primer apellido inicia con vocal, segundo apellido y fecha de nacimiento' do
          generator = RfcGenerator.new(nombre:           'Juan',
                                       primer_apellido:  'Antonio',
                                       segundo_apellido: 'Fernández',
                                       fecha_nacimiento:  Date.new(1970, 12, 13))
          generator.rfc.must_equal 'AOFJ701213LN8'
        end

        it 'nombre, primer apellido inicia con letra compuesta, segundo apellido y fecha de nacimiento' do
          generator = RfcGenerator.new(nombre:           'Charles',
                                       primer_apellido:  'Chávez',
                                       segundo_apellido: 'Llamas',
                                       fecha_nacimiento:  Date.new(1970, 12, 13))
          generator.rfc.must_equal 'CALC701213R55'
        end

        it 'nombre, primer apellido sin vocal interna, segundo apellido y fecha de nacimiento' do
          generator = RfcGenerator.new(nombre:           'Álvaro',
                                       primer_apellido:  'de la O',
                                       segundo_apellido: 'Lozano',
                                       fecha_nacimiento:  Date.new(1970, 12, 13))
          generator.rfc.must_equal 'OLAL701213R92'

          generator = RfcGenerator.new(nombre:           'Ernesto',
                                       primer_apellido:  'Ek',
                                       segundo_apellido: 'Rivera',
                                       fecha_nacimiento:  Date.new(1970, 12, 13))
          generator.rfc.must_equal 'ERER7012139E5'
        end

        it 'nombre, sin primer apellido, segundo apellido y fecha de nacimiento' do
          generator = RfcGenerator.new(nombre:           'Gerarda',
                                       primer_apellido:   nil,
                                       segundo_apellido: 'Zafra',
                                       fecha_nacimiento:  Date.new(1970, 12, 13))
          generator.rfc.must_equal 'ZAGE701213920'
        end

        it 'nombre, primer apellido, sin segundo apellido, fecha de nacimiento' do
          generator = RfcGenerator.new(nombre:           'Juan',
                                       primer_apellido:  'Martínez',
                                       segundo_apellido:  nil,
                                       fecha_nacimiento:  Date.new(1970, 12, 13))
          generator.rfc.must_equal 'MAJU701213BP2'
        end

        it 'Nombre, primer apellido con caracter especial, segundo apellido y fecha de nacimiento' do
          generator = RfcGenerator.new(nombre:           'Roberto',
                                       primer_apellido:  "O'farril",
                                       segundo_apellido: 'Carballo',
                                       fecha_nacimiento:  Date.new(1970, 12, 13))
          generator.rfc.must_equal 'OACR701213B44'

          generator = RfcGenerator.new(nombre:           'Rubén',
                                       primer_apellido:  "D'angelo",
                                       segundo_apellido: 'Fargo',
                                       fecha_nacimiento:  Date.new(1970, 12, 13))
          generator.rfc.must_equal 'DAFR701213127'

          generator = RfcGenerator.new(nombre:           'Luz Ma.',
                                       primer_apellido:  'Fernández',
                                       segundo_apellido: 'Juárez',
                                       fecha_nacimiento:  Date.new(1970, 12, 13))
          generator.rfc.must_equal 'FEJL701213158'
        end

        it 'palabra inapropiada' do
          generator = RfcGenerator.new(nombre:           'Omar',
                                       primer_apellido:  'Pérez',
                                       segundo_apellido: 'Domínguez',
                                       fecha_nacimiento:  Date.new(1970, 12, 13))
          generator.rfc.must_equal 'PEDX7012139FA'
        end
      end #Describe persona física

      describe 'Persona moral' do
        it 'takes the first letter of three words' do
          generator = RfcGenerator.new(razon_social: 'Sonora Industrial Azucarera, S. de R.L',
                                       fecha_creacion: Date.new(1983, 03, 05))
          generator.rfc.must_equal 'SIA8303054L5'
        end

        it 'takes the first letter of three words skipping invalid words' do
          generator = RfcGenerator.new(razon_social: 'Artículos de piel y Baúles, S. de R. L.',
                                       fecha_creacion: Date.new(1983, 03, 05))
          generator.rfc.must_equal 'APB830305QS6'
        end

        it 'ignores the second letter of the compound letters' do
          generator = RfcGenerator.new(razon_social: 'Champion Mexicana de Bujías, S.A.',
                                       fecha_creacion: Date.new(1983, 03, 05))
          generator.rfc.must_equal 'CMB830305L62'
        end

        it 'ignores the dot and takes single letters' do
          generator = RfcGenerator.new(razon_social: 'U.S. Ruber Mexicana, S.A.',
                                       fecha_creacion: Date.new(1983, 03, 05))
          generator.rfc.must_equal 'USR830305L44'
        end

        it 'takes the first letter from first word and two letters from second word' do
          generator = RfcGenerator.new(razon_social: 'Aceros Ecatepec, S.A.',
                                       fecha_creacion: Date.new(1983, 03, 05))
          generator.rfc.must_equal 'AEC83030546A'
        end

        it 'takes the three letters from first word' do
          generator = RfcGenerator.new(razon_social: 'Arsuyama, S.A.',
                                       fecha_creacion: Date.new(1983, 03, 05))
          generator.rfc.must_equal 'ARS830305GYA'
        end

        it 'adds xx when the company name has one letter' do
          generator = RfcGenerator.new(razon_social: 'Z, S.A.',
                                       fecha_creacion: Date.new(1983, 03, 05))
          generator.rfc.must_equal 'ZXX830305BLA'
        end

        it 'ignores invalid words (los, de)' do
          generator = RfcGenerator.new(razon_social: 'Los Viajes Internacionales de Marco Polo, S.A.',
                                       fecha_creacion: Date.new(1983, 03, 05))
          generator.rfc.must_equal 'VIM8303056B6'
        end

        it 'ignores invalid words (y, para)' do
          generator = RfcGenerator.new(razon_social: 'Artículos y Accesorios para Automóviles, S.A.',
                                       fecha_creacion: Date.new(1983, 03, 05))
          generator.rfc.must_equal 'AAA830305184'
        end

        it 'ignores invalid words (el)' do
          generator = RfcGenerator.new(razon_social: 'El abastecedor Ferretero, S.A.',
                                       fecha_creacion: Date.new(1983, 03, 05))
          generator.rfc.must_equal 'AFE830305STA'
        end

        it 'ignores (compañia)' do
          generator = RfcGenerator.new(razon_social: 'Compañía Periodística Nacional, S.A.',
                                       fecha_creacion: Date.new(1983, 03, 05))
          generator.rfc.must_equal 'PNA830305LT5'
        end

        it 'ignores (cia.)' do
          generator = RfcGenerator.new(razon_social: 'Pimienta Hnos. y Cía., S.A.',
                                       fecha_creacion: Date.new(1983, 03, 05))
          generator.rfc.must_equal 'PHN830305RY9'
        end
      end

    end

  end
end
