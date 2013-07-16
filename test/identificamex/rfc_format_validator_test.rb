require_relative '../test_helper'
require_relative '../empleado'

describe 'rfc validator' do

  def model(options)
    Empleado.new(options)
  end

  def model_homoclave(options)
    EmpleadoHomoclave.new(options)
  end

  describe 'with valid data' do
    it 'accepts rfc (completo)' do
      model(rfc: 'AEIO111111AEI').must_be :valid?
    end

    it 'accepts rfc (con 3 carácteres para el nombre)' do
      model(rfc: 'AEI111111AEI').must_be :valid?
    end

    it 'accepts rfc (sin homoclave)' do
      model(rfc: 'AEIO111111').must_be :valid?
    end

    it 'accepts rfc (sin homoclave y con 3 carácteres para el nombre)' do
      model(rfc: 'AEI111111').must_be :valid?
    end

    it 'accepts rfc (datos de nombre con Ñ)' do
      model(rfc: 'ÑAEI111111AEI').must_be :valid?
    end

    it 'accepts rfc (datos de nombre con &)' do
      model(rfc: 'A&O111111AEI').must_be :valid?
    end

    describe 'force homoclave' do
      it 'accepts rfc (4 carácteres para el nombre, sin homoclave)' do
        model_homoclave(rfc: 'AEIO111111').wont_be :valid?
      end

      it 'accepts rfc (3 carácteres para el nombre, sin homoclave)' do
        model_homoclave(rfc: 'AEI111111').wont_be :valid?
      end
    end # describe force homoclave

  end # with valid data

  describe 'with invalid data' do
    it 'refuses rfc (nombre con dígito en lugar de letra)' do
      model(rfc: '9AEI111111').wont_be :valid?
    end

    it 'refuses rfc (carácter inválido)' do
      model(rfc: 'A*OU111111').wont_be :valid?
    end

    it 'refuses rfc (falta un dígito en la fecha)' do
      model(rfc: 'AEIO11111').wont_be :valid?
    end

    it 'refuses rfc (falta un carácter en los datos del nombre)' do
      model(rfc: 'AE111111').wont_be :valid?
    end

    it 'refuses rfc (el día es inválido, 42)' do
      model(rfc: 'AEIO111142').wont_be :valid?
    end

    it 'refuses rfc (el mes es inváido, 25)' do
      model(rfc: 'AEIO112511').wont_be :valid?
    end

    it 'refuses rfc (homoclave incompleta)' do
      model(rfc: 'AEIO111111A').wont_be :valid?
    end

    describe 'force homoclave' do
      it 'refuses rfc (4 carácteres para el nombre, sin homoclave)' do
        model_homoclave(rfc: 'AEIO111111').wont_be :valid?
      end

      it 'refuses rfc (3 carácteres para el nombre, sin homoclave)' do
        model_homoclave(rfc: 'AEI111111').wont_be :valid?
      end
    end # describe force homoclave

  end # with invalid data

end
