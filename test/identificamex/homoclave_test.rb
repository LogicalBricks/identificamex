require_relative '../test_helper'
require_relative '../../lib/identificamex/homoclave'

module Identificamex
  describe Homoclave do
    context 'persona física' do
      it 'builds homoclave' do
        rfc_base = OpenStruct.new(nombre_completo: 'GOMEZ DIAZ EMMA', siglas: 'GODE561231') # kind of stub
        assert_equal 'GR8', Homoclave.new(rfc_base).siglas
      end
    end

    context 'persona moral' do
      it 'builds homoclave' do
        rfc_base = OpenStruct.new(nombre_completo: 'LOGICALBRICKS SOLUTIONS', siglas: 'LSO110121') # kind of stub
        assert_equal 'SY0', Homoclave.new(rfc_base).siglas
      end
    end
  end
end
