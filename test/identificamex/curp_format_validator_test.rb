require_relative '../test_helper'
require_relative '../empleado'

describe 'curp validator' do

  describe 'with valid data' do
    it 'accepts curp (hombre)' do
      Empleado.new(curp: 'AAAA111111HDFBBB01').must_be :valid?
    end

    it 'accepts curp (mujer)' do
      Empleado.new(curp: 'AAAA111111MDFBBB01').must_be :valid?
    end

    it 'accepts curp (digito anti-duplicado alfanumérico)' do
      Empleado.new(curp: 'AAAA111111HDFBBBA1').must_be :valid?
    end
  end # with valid data

  describe 'with invalid data' do
    it 'refuses curp (nombre con digito en lugar de letra)' do
      Empleado.new(curp: '9AAA111111HDFBBB01').wont_be :valid?
    end

    it 'refuses curp (caracter invalido)' do
      Empleado.new(curp: 'A*AA111111HDFBBB01').wont_be :valid?
    end

    it 'refuses curp (falta un digito en la fecha)' do
      Empleado.new(curp: 'AAAA11111HDFBBB01').wont_be :valid?
    end

    it 'refuses curp (falta un caracter en los datos del nombre)' do
      Empleado.new(curp: 'AAA111111HDFBBB01').wont_be :valid?
    end

    it 'refuses curp (el dia es invalido 42)' do
      Empleado.new(curp: 'AAAA111142HDFBBB01').wont_be :valid?
    end

    it 'refuses curp (el mes es invaido 25)' do
      Empleado.new(curp: 'AAAA112511HDFBBB01').wont_be :valid?
    end

    it 'refuses curp (sexo es inválido K)' do
      Empleado.new(curp: 'AAAA111111KDFBBB01').wont_be :valid?
    end

    it 'refuses curp (caracteres de consonantes tiene alguna vocal)' do
      Empleado.new(curp: 'AAAA111111HDFABB01').wont_be :valid?
      Empleado.new(curp: 'AAAA111111HDFBAB01').wont_be :valid?
      Empleado.new(curp: 'AAAA111111HDFBBA01').wont_be :valid?
    end

    it 'refuses curp (digito verificador alfanumérico)' do
      Empleado.new(curp: 'AAAA111111HDFBBB0A').wont_be :valid?
    end
  end # with invalid data

end
