require_relative '../test_helper'

class Dummy
  include Identificamex::Methods
end

describe 'test helper' do
  it 'returns true when the RFC is valid for persona moral' do
    params = { razon_social: 'Sonora Industrial Azucarera, S. de R.L',
               fecha_creacion:  Date.new(1983, 03, 05) }
    assert Dummy.new.valid_rfc?('SIA8303054L5', params)
  end

  it 'returns true when the RFC is valid for persona fisica' do
    params = { nombre: 'Juan',
               primer_apellido:  'Barrios',
               segundo_apellido: 'Fernández',
               fecha_nacimiento:  Date.new(1970, 12, 13) }
    assert Dummy.new.valid_rfc?('BAFJ701213SBA', params)
  end

  it 'returns false when the RFC is invalid for persona moral' do
    params = { razon_social: 'Sonora Industrial Azucarera Moderna, S. de R.L',
               fecha_creacion:  Date.new(1983, 03, 05) }
    assert !Dummy.new.valid_rfc?('SIA8303054L5', params)
  end

  it 'returns false when the RFC is valid for persona física' do
    params = { nombre: 'Juan José',
               primer_apellido:  'Barrios',
               segundo_apellido: 'Fernández',
               fecha_nacimiento:  Date.new(1970, 12, 13) }
    assert !Dummy.new.valid_rfc?('BAFJ701213SBA', params)
  end
end
