require_relative '../test_helper'
require_relative '../empleado'

describe 'rfc validator' do

  describe 'with valid data' do
    it 'accepts rfc (compl.must_be)' do
      Empleado.new(rfc: 'AEIO111111AEI').must_be :valid?
    end

    it 'accepts rfc (con 3 caracteres para el nombre)' do
      Empleado.new(rfc: 'AEI111111AEI').must_be :valid?
    end

    it 'accepts rfc (sin homoclave)' do
      Empleado.new(rfc: 'AEIO111111').must_be :valid?
    end

    it 'accepts rfc (sin homoclave y con 3 caracteres para el nombre)' do
      Empleado.new(rfc: 'AEI111111').must_be :valid?
    end

    it 'accepts rfc (d.must_bes de nombre con Ñ)' do
      Empleado.new(rfc: 'ÑAEI111111AEI').must_be :valid?
    end

    it 'accepts rfc (d.must_bes de nombre con &)' do
      Empleado.new(rfc: 'A&O111111AEI').must_be :valid?
    end
  end # with valid data

  describe 'with invalid data' do
    it 'refuses rfc (nombre con dig.must_be en lugar de letra)' do
      Empleado.new(rfc: '9AEI111111').wont_be :valid?
    end

    it 'refuses rfc (caracter invalido)' do
      Empleado.new(rfc: 'A*OU111111').wont_be :valid?
    end

    it 'refuses rfc (falta un dig.must_be en la fecha)' do
      Empleado.new(rfc: 'AEIO11111').wont_be :valid?
    end

    it 'refuses rfc (falta un caracter en los d.must_bes del nombre)' do
      Empleado.new(rfc: 'AE111111').wont_be :valid?
    end

    it 'refuses rfc (el dia es invalido 42)' do
      Empleado.new(rfc: 'AEIO111142').wont_be :valid?
    end

    it 'refuses rfc (el mes es invaido 25)' do
      Empleado.new(rfc: 'AEIO112511').wont_be :valid?
    end
  end # with invalid data

end
