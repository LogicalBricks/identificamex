require_relative '../../test_helper'
require_relative '../../../lib/identificamex/rfc/rfc_base'

module Identificamex
  module Rfc

    describe RfcBase do
      context 'persona física' do
        it 'builds rfc base' do
          nombre = NombreCompleto.new(
            nombre: 'Emma',
            primer_apellido: 'Gómez',
            segundo_apellido: 'Díaz'
          )
          fecha = Date.new(1956, 12, 31)
          rfc_base = RfcBase.new(nombre: nombre, fecha_nacimiento: fecha)
          assert_equal 'GODE561231', rfc_base.siglas
        end
      end
    end

  end
end
