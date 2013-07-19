require_relative '../test_helper'
require_relative '../../lib/identificamex/nombre_completo'

module Identificamex
  describe NombreCompleto do
    describe '#primera_letra_primer_apellido' do

      describe 'when the words have no invalid words' do
        it 'is the first letter' do
          NombreCompleto.new(primer_apellido: 'MARTINEZ').primera_letra_primer_apellido.must_equal 'M'
        end
      end

      describe 'when the words have invalid words' do
        it 'is the first letter skipping invalid words' do
          NombreCompleto.new(primer_apellido: 'DE LA ROSA').primera_letra_primer_apellido.must_equal 'R'
        end
      end

      describe 'when primer_apellido is nil' do
        it 'is nil' do
          NombreCompleto.new(primer_apellido: nil).primera_letra_primer_apellido.must_equal nil
        end
      end
    end # describe #primera_letra_primer_apellido

    describe '#primera_vocal_interna_primer_apellido' do
      describe 'when the word starts with a vowel' do
        it 'is the first vowel' do
          NombreCompleto.new(primer_apellido: 'RAMIREZ').primera_vocal_interna_primer_apellido.must_equal 'A'
        end
      end

      describe 'when the word starts with a consonant' do
        it 'is the second vowel' do
          NombreCompleto.new(primer_apellido: 'ANTONIO').primera_vocal_interna_primer_apellido.must_equal 'O'
        end
      end

      describe 'when primer_apellido is nil' do
        it 'is nil' do
          NombreCompleto.new(primer_apellido: nil).primera_vocal_interna_primer_apellido.must_equal nil
        end
      end
    end # describe primera_vocal_interna_primer_apellido

    describe '#primera_letra_segundo_apellido' do
      describe 'when the words have no invalid word' do
        it 'is the first letter' do
          NombreCompleto.new(segundo_apellido: 'RAMIREZ').primera_letra_segundo_apellido.must_equal 'R'
        end
      end

      describe 'when the words have invalid words' do
        it 'is the first letter skipping the invalid words' do
          NombreCompleto.new(segundo_apellido: 'DEL TORO').primera_letra_segundo_apellido.must_equal 'T'
        end
      end

      describe 'when segundo_apellido is nil' do
        it 'is nil' do
          NombreCompleto.new(primer_apellido: nil).primera_letra_segundo_apellido.must_equal nil
        end
      end
    end # describe #primera_letra_segundo_apellido

    describe '#primera_letra_nombre' do
      describe 'when words have invalid words' do
        it 'is the first letter of the first word' do
          NombreCompleto.new(nombre: 'ALBERTO').primera_letra_nombre.must_equal 'A'
        end
      end

      describe 'when words have no invalid words' do
        it 'is the first letter of the word skipping the invalid ones' do
          NombreCompleto.new(nombre: 'JOSE ALBERTO').primera_letra_nombre.must_equal 'A'
        end
      end

      describe 'when nombre is nil' do
        it 'is nil' do
          NombreCompleto.new(nombre: nil).primera_letra_nombre.must_equal nil
        end
      end
    end # describe #primera_letra_nombre

    describe '#primeras_dos_letras_nombre' do
      describe 'when words have invalid words' do
        it 'is the first letter of the first word' do
          NombreCompleto.new(nombre: 'ALBERTO').primeras_dos_letras_nombre.must_equal 'AL'
        end
      end

      describe 'when words have no invalid words' do
        it 'is the first letter of the word skipping the invalid ones' do
          NombreCompleto.new(nombre: 'JOSE ALBERTO').primeras_dos_letras_nombre.must_equal 'AL'
        end
      end

      describe 'when nombre is nil' do
        it 'is nil' do
          NombreCompleto.new(nombre: nil).primeras_dos_letras_nombre.must_equal nil
        end
      end
    end # describe #primeras_dos_letras_nombre

    describe '#siglas_apellidos' do
      describe 'only primer_apellido is present' do
        it 'takes the first two letters of the primer_apellido' do
          NombreCompleto.new(primer_apellido: 'LOPEZ', segundo_apellido: nil)
          .siglas_apellidos.must_equal 'LO'
        end
      end

      describe 'only segundo_apellido is present' do
        it 'takes the first two letters of the segundo_apellido' do
          NombreCompleto.new(primer_apellido: nil, segundo_apellido: 'SANCHEZ')
          .siglas_apellidos.must_equal 'SA'
        end
      end

      describe 'both are present' do
        describe 'primer_apellido is large enough' do
          it 'takes the first letter and the first interna vowel of the primer_apellido plus the first letter of the segundo_apellido' do
            NombreCompleto.new(primer_apellido: 'LOPEZ', segundo_apellido: 'SANCHEZ')
            .siglas_apellidos.must_equal 'LOS'
          end
        end

        describe 'primer_apellido is not large enough' do
          it 'takes the first letter and the first interna vowel of the primer_apellido plus the first letter of the segundo_apellido' do
            NombreCompleto.new(primer_apellido: 'DE LA O', segundo_apellido: 'SANCHEZ')
            .siglas_apellidos.must_equal 'OS'

            NombreCompleto.new(primer_apellido: 'EK', segundo_apellido: 'SANCHEZ')
            .siglas_apellidos.must_equal 'ES'
          end
        end
      end
    end # describe #siglas_apellidos

    describe '#siglas_apellidos_completa?' do
      describe "when siglas apellidos' length is 3" do
        it 'is true' do
            NombreCompleto.new(primer_apellido: 'LOPEZ', segundo_apellido: 'SANCHEZ')
            .siglas_apellidos_completa?.must_equal true
        end
      end

      describe "when siglas apellidos' length is 2" do
        it 'is false' do
          NombreCompleto.new(primer_apellido: 'DE LA O', segundo_apellido: 'SANCHEZ')
          .siglas_apellidos_completa?.must_equal false
        end
      end
    end # describe #siglas_apellidos_completa?

    describe '#siglas' do
      it 'takes 3 letters from the last names and 1 from the first name' do
        NombreCompleto.new(primer_apellido: 'LOPEZ', segundo_apellido: 'SANCHEZ', nombre: 'RAMIRO')
        .siglas.must_equal 'LOSR'
      end

      it 'takes 2 letters from the last names and 2 from the first name' do
        NombreCompleto.new(primer_apellido: 'DE LA O', segundo_apellido: 'SANCHEZ', nombre: 'RAMIRO')
        .siglas.must_equal 'OSRA'
      end
    end #describe #siglas
  end
end
