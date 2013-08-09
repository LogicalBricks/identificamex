require_relative '../../test_helper'
require_relative '../../../lib/identificamex/nombre/normalizador_nombre'

module Identificamex
  module Nombre

    describe NormalizadorNombre do
      it 'keeps (MARTHA)' do
        NormalizadorNombre.new('Martha').normalizar.must_equal 'MARTHA'
      end

      it 'removes MARIA' do
        NormalizadorNombre.new('María Fernanda').normalizar.must_equal 'FERNANDA'
      end

      it 'removes MARIA DEL' do
        NormalizadorNombre.new('María del Carmen').normalizar.must_equal 'CARMEN'
      end

      it 'removes MARIA DE' do
        NormalizadorNombre.new('María de Lourdes').normalizar.must_equal 'LOURDES'
      end

      it 'removes MARIA DE LOS' do
        NormalizadorNombre.new('María de los Ángeles').normalizar.must_equal 'ANGELES'
      end

      it 'removes MARIA DE LA' do
        NormalizadorNombre.new('María de la Trinidad').normalizar.must_equal 'TRINIDAD'
      end

      it 'keeps MARIA' do
        NormalizadorNombre.new('María').normalizar.must_equal 'MARIA'
      end

      it 'keeps MARIA' do
        NormalizadorNombre.new('María José').normalizar.must_equal 'MARIA'
      end

      it 'keeps (ANTONIO)' do
        NormalizadorNombre.new('Antonio').normalizar.must_equal 'ANTONIO'
      end

      it 'removes JOSE' do
        NormalizadorNombre.new('José Fernando').normalizar.must_equal 'FERNANDO'
      end

      it 'removes JOSE DE' do
        NormalizadorNombre.new('José de Jesús').normalizar.must_equal 'JESUS'
      end

      it 'keeps JOSE' do
        NormalizadorNombre.new('José').normalizar.must_equal 'JOSE'
      end

      it 'keeps JOSE' do
        NormalizadorNombre.new('José María').normalizar.must_equal 'JOSE'
      end
    end

  end
end
