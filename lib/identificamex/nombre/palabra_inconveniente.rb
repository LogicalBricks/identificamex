module Identificamex
  module Nombre

    class PalabraInconveniente
      def self.convertir(palabra)
        hash_palabras[palabra] || palabra
      end

      def self.hash_palabras
        @hash_palabras ||= {
          'BUEI' => 'BUEX',
          'BUEY' => 'BUEX',
          'CACA' => 'CACX',
          'CACO' => 'CACX',
          'CAGA' => 'CAGX',
          'CAGO' => 'CAGX',
          'CAKA' => 'CAKX',
          'COGE' => 'COGX',
          'COJA' => 'COJX',
          'COJE' => 'COJX',
          'COJI' => 'COJX',
          'COJO' => 'COJX',
          'CULO' => 'CULX',
          'FETO' => 'FETX',
          'GUEY' => 'GUEX',
          'JOTO' => 'JOTX',
          'KACA' => 'KACX',
          'KACO' => 'KACX',
          'KAGA' => 'KAGX',
          'KAGO' => 'KAGX',
          'KOGE' => 'KOGX',
          'KOJO' => 'KOJX',
          'KAKA' => 'KAKX',
          'KULO' => 'KULX',
          'MAME' => 'MAMX',
          'MAMO' => 'MAMX',
          'MEAR' => 'MEAX',
          'MEON' => 'MEOX',
          'MION' => 'MIOX',
          'MOCO' => 'MOCX',
          'MULA' => 'MULX',
          'PEDA' => 'PEDX',
          'PEDO' => 'PEDX',
          'PENE' => 'PENX',
          'PUTA' => 'PUTX',
          'PUTO' => 'PUTX',
          'QULO' => 'QULX',
          'RATA' => 'RATX',
          'RUIN' => 'RUIX'
        }
      end
    end

  end
end
