module Donna
  class Mensaje
    attr_accessor :usuarie, :contexto, :config

    def initialize(usuarie:, contexto:)
      @usuarie = usuarie
      @contexto = contexto
    end

    def start
      respuesta = ["Hola #{usuarie.nombre(contexto)}!"]

      # TODO, Incluir la información sobre mensajes directos.
      if usuarie.pronombres
        respuesta << "Me acuerdo que me dijiste:"
        respuesta << "\"#{usuarie.pronombres}\" sobre pronombres."
      end

      respuesta.join "\n\n"
    end

    def stop
      "Chau #{usuarie}!"
    end

    def pronombres
      [
        "Decime cómo son tus pronombres y cuando alguien me pregunte por vos les digo.",
        "Podés elegir una de estas opciones, o escribir lo que quieras (soon™)."
      ].join "\n\n"
    end

    # TODO, Opción para "todos", "me da igual" o "quiero escribirlo".
    def opciones_para_pronombres
      [
        'Ella',
        'Ella/elle',
        'Ella/él',
        'Elle',
        'Elle/él',
        'Él',
        'Ella/elle/él'
      ]
    end

    def respuesta_pronombres(valor)
      usuarie.update pronombres: valor

      "Perfecto! Cuando me pregunten por tus pronombres les voy a decir eso ☺️"
    end

    def contame_de(alguien)
      if alguien
        [
          "En cuanto al uso de pronombres, esto es lo que me dijo #{alguien.username(contexto)}:",
          "\"#{alguien.pronombres}\""
        ].join "\n\n"
      else
        "Tenés que decirme el @! Así: /contame_de @#{Donna::Config.instance.telegram['botname']}"
      end
    end

    def about
      'Soy Donna Auchaway. Mis pronombres son neutros (elle) y soy le cyborg de Auch!'
    end

    def eco(mensaje)
      "No entiendo \"#{mensaje}\""
    end
  end
end
