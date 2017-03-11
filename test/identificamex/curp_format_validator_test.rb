require_relative '../test_helper'
require_relative '../empleado'

describe 'curp validator' do

  def model(options)
    Empleado.new(options)
  end

  describe 'with valid data' do
    it 'accepts curp (hombre)' do
      model(curp: 'AAAA111111HDFBBB01').must_be :valid?
    end

    it 'accepts curp (mujer)' do
      model(curp: 'AAAA111111MDFBBB01').must_be :valid?
    end

    it 'accepts curp (digito anti-duplicado alfanumérico)' do
      model(curp: 'AAAA111111HDFBBBA1').must_be :valid?
    end

    it 'accepts generic curp (for man)' do
      model(curp: 'XEXX010101MNEXXXA8').must_be :valid?
    end

    it 'accepts generic curp (for woman)' do
      model(curp: 'XEXX010101HNEXXXA4').must_be :valid?
    end

    it 'accepts curp for foreing nationatily' do
      model(curp: 'AAAA111111HNEBBB01').must_be :valid?
    end
  end # with valid data

  describe 'with invalid data' do
    it 'refuses curp (nombre con dígito en lugar de letra)' do
      model(curp: '9AAA111111HDFBBB01').wont_be :valid?
    end

    it 'refuses curp (caracter inválido)' do
      model(curp: 'A*AA111111HDFBBB01').wont_be :valid?
    end

    it 'refuses curp (falta un dígito en la fecha)' do
      model(curp: 'AAAA11111HDFBBB01').wont_be :valid?
    end

    it 'refuses curp (falta un carácter en los datos del nombre)' do
      model(curp: 'AAA111111HDFBBB01').wont_be :valid?
    end

    it 'refuses curp (el dia es inválido 42)' do
      model(curp: 'AAAA111142HDFBBB01').wont_be :valid?
    end

    it 'refuses curp (el mes es inválido 25)' do
      model(curp: 'AAAA112511HDFBBB01').wont_be :valid?
    end

    it 'refuses curp (sexo es inválido K)' do
      model(curp: 'AAAA111111KDFBBB01').wont_be :valid?
    end

    it 'refuses curp (caracteres de consonantes tiene alguna vocal)' do
      model(curp: 'AAAA111111HDFABB01').wont_be :valid?
      model(curp: 'AAAA111111HDFBAB01').wont_be :valid?
      model(curp: 'AAAA111111HDFBBA01').wont_be :valid?
    end

    it 'refuses curp (digito verificador alfanumérico)' do
      model(curp: 'AAAA111111HDFBBB0A').wont_be :valid?
    end

    it 'refuses curp with invalid state code' do
      model(curp: 'AAAA111111HFEBBB01').wont_be :valid?
    end
  end # with invalid data

end
