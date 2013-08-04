module Identificamex
  class RazonSocial
    include Mayusculas

    def initialize(razon_social)
      @razon_social = mayusculas(razon_social)
    end

    def siglas
      tres_letras_de_razon_social
    end

    def to_s
      @razon_social
    end

    private

    def tres_letras_de_razon_social
      case palabras_a_considerar.count
      when 3 then siglas_tres_palabras
      when 2 then siglas_dos_palabras
      else siglas_palabra_unica
      end
    end

    def palabras_a_considerar
      @palabras_a_considerar ||= palabras_razon_social[0, 3]
    end

    def siglas_tres_palabras
      palabras_a_considerar.map{|l| l[0]}.join
    end

    def siglas_dos_palabras
      palabras_a_considerar[0][0] + palabras_a_considerar[1][0, 2]
    end

    def siglas_palabra_unica
      letras = palabras_a_considerar.first[0, 3]
      letras = letras + ("X" * (3 - letras.length)) if letras.length < 3
      letras
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
