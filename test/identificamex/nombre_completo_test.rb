require_relative '../test_helper'
require_relative '../../lib/identificamex/nombre_completo'

module Identificamex
  describe NombreCompleto do

    describe '#to_s' do
      it 'is (primer apellido segundo apellido y nombre)' do
        params = {nombre: 'José Alfredo', primer_apellido: 'Martínez', segundo_apellido: 'López'}
        nombre_completo = NombreCompleto.new(params).to_s.must_equal 'MARTINEZ LOPEZ JOSE ALFREDO'
      end
    end

    describe '#siglas' do
      context 'usual cases' do
        it 'takes 2 letters from primero_apellido, 1 from segundo_apellido and 1 from the nombre' do
          params = {primer_apellido: 'Lopez', segundo_apellido: 'Sanchez', nombre: 'Ramiro'}
          NombreCompleto.new(params).siglas.must_equal 'LOSR'
        end

        it 'takes 2 letters from primero_apellido, 1 from segundo_apellido and 1 from the nombre' do
          params = {primer_apellido: 'Antonio', segundo_apellido: 'Sanchez', nombre: 'Ramiro'}
          NombreCompleto.new(params).siglas.must_equal 'AOSR'
        end
      end

      context 'special cases' do
        context 'nombre, primer_apellido and segundo_apellido have invalid words' do
          it 'takes the letters ignoring invalid words' do
          params = {primer_apellido: 'Del Angel', segundo_apellido: 'De la Rosa', nombre: 'Jose Ramiro'}
            NombreCompleto.new(params).siglas.must_equal 'AERR'
          end
        end

        context 'when primer_apellido has just one letter' do
          it 'takes 1 letter from primer_apellido, 1 from sengudo_apellido and 2 from nombre' do
          params = {primer_apellido: 'DE LA O', segundo_apellido: 'SANCHEZ', nombre: 'RAMIRO'}
            NombreCompleto.new(params).siglas.must_equal 'OSRA'
          end
        end

        context 'when primer_apellido is nil' do
          it 'takes 2 letters from segundo_apellido and 2 letters from nombre' do
          params = {primer_apellido: nil, segundo_apellido: 'SANCHEZ', nombre: 'RAMIRO'}
            NombreCompleto.new(params).siglas.must_equal 'SARA'
          end
        end

        context 'when segundo_apellido is nil' do
          it 'takes 2 letters from primer_apellido and 2 letters from nombre' do
          params = {primer_apellido: 'Sanchez', segundo_apellido: nil, nombre: 'RAMIRO'}
            NombreCompleto.new(params).siglas.must_equal 'SARA'
          end
        end

      end # context especial cases


    end #describe #siglas
  end
end
