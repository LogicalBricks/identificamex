require_relative '../test_helper'
require_relative '../../lib/identificamex/normalizador_apellido'

module Identificamex
  describe NormalizadorApellido do
    it 'keeps (SANCHEZ)' do
      NormalizadorNombre.new('Sánchez').normalizar.must_equal 'SANCHEZ'
    end

    it 'removes DE LA' do
      NormalizadorNombre.new('De la Rosa').normalizar.must_equal 'ROSA'
    end

    it 'removes DEL' do
      NormalizadorNombre.new('Del Toro').normalizar.must_equal 'TORO'
    end

    it 'removes DE LOS' do
      NormalizadorNombre.new('De los Santos').normalizar.must_equal 'SANTOS'
    end

    it 'removes LA' do
      NormalizadorNombre.new('La Torre').normalizar.must_equal 'TORRE'
    end

  end
end
