module Donna
  class Mensaje
    attr_accessor :usuarie

    def initialize(usuarie:)
      @usuarie = usuarie
    end

    def start
      "Hola #{usuarie}"
    end

    def stop
      "Chau #{usuarie}"
    end

    def about
      'Soy Donna Auchaway. Mis pronombres son neutros (elle) y soy le cyborg de Auch!'
    end

    def eco(mensaje)
      "No entiendo \"#{mensaje}\""
    end
  end
end
