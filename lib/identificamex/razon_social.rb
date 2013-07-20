module Identificamex
  class RazonSocial
    include Mayusculas

    def initialize(razon_social)
      @razon_social = mayusculas(razon_social)
    end

    def present?
      @razon_social.present?
    end

    def siglas
      tres_letras_de_razon_social
    end

    private

    def tres_letras_de_razon_social
      palabras = palabras_razon_social[0, 3]
      if palabras.count == 3
        siglas_tres_palabras(palabras)
      elsif palabras.count == 2
        siglas_dos_palabras(palabras)
      else
        siglas_palabra_unica(palabras)
      end
    end

    def siglas_tres_palabras(palabras)
      palabras.map{|l| l[0]}.join
    end

    def siglas_dos_palabras(palabras)
      palabras[0][0] + palabras[1][0, 2]
    end

    def siglas_palabra_unica(palabra)
      s = palabra.first[0, 3]
      s = s + ("X" * (3 - s.length)) if s.length < 3
      s
    end

    def palabras_razon_social
      eliminar_abrebiaturas(@razon_social)
      .split
      .map{|p| p.split('.') }
      .flatten
      .select{|p| !palabras_especiales.member?(p) }
    end

    def eliminar_abrebiaturas(str)
      abreviaturas.each do |pf|
        str.gsub!(pf, '')
      end
      str
    end

    def palabras_especiales
      %w[DE Y DEL LOS LAS LA EL PARA]
    end

    def abreviaturas
      [
        /COMPAÑIA/,
        /CIA\./,
        /\ASOCIEDAD/,
        /\ASOC\./,
        /S\.? EN N\.? ?C\.?\z/,
        /S\.? EN C\.?\z/,
        /S\.? DE R\.? ?L\.?\z/,
        /S\.? EN C\.? POR A\.?\z/,
        /S\.? ?A\.?\z/,
        /S\.? ?A\.? DE C\.? ?V\.?\z/,
        /S\.? ?N\.?C\.?\z/,
        /S\.? ?C\.?\z/,
        /A\.? ?C\.?\z/,
        /A\.? EN P\.?\z/,
        /S\.? ?C\.? ?L\.?\z/,
        /S\.? ?C\.? ?S\.?\z/
      ]
    end

  end
end
