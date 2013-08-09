module Identificamex
  class RfcBase
    def initialize(params)
      @nombre = params[:nombre] || params[:nombre_completo] || params[:razon_social]
      @fecha = params[:fecha] || params[:fecha_nacimiento] || params[:fecha_creacion]
    end

    def siglas
      @siglas ||= generar_siglas
    end

    def nombre_completo
      @nombre.to_s
    end

    #=====================
    private
    #=====================

    def generar_siglas
      @nombre.siglas + fecha_formateada
    end

    def fecha_formateada
      @fecha.strftime('%y%m%d')
    end

    def convertir_palabra_inconveniente(palabra)
      PalabraInconveniente.convertir(palabra)
    end

  end
end
