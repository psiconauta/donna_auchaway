module Donna
  class Mensaje
    attr_accessor :usuarie, :contexto, :config

    def initialize(usuarie:, contexto:)
      @usuarie = usuarie
      @contexto = contexto
    end

    def config
      Donna::Config.instance
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
      "Chau #{usuarie.nombre(contexto)}!"
    end

    # TODO, Tal vez haya que ajustar el mensaje al contexto.
    def help
      case contexto
      when :telegram
        [
          config.telegram['description'].strip,
          "Estos son los comandos para comunicarte conmigo:",
          config.telegram['commands'].strip,
          "Podés escribir cualquier comando (acordate de la <code>/</code> adelante)," \
          " elegirlos desde acá, o elegirlos del botoncito parecido a <code>[/]</code>" \
          " que debería estar en el menú. Para preguntarme por alguien en particular" \
          " con /contame_de, tenés que escribir el comando, seguido de su nombre de" \
          " usuarie (su @), así:",
          "<code>/contame_de @NombreDeUsuarieInventado</code>",
          "El nombre de usuarie lo podés ver en su perfil."
        ].join "\n\n"
      end
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
        "Tenés que decirme el @! Así: /contame_de @#{config.botname(contexto)}"
      end
    end

    def about
      'Soy Donna Auchaway. Mis pronombres son neutros (elle) y soy le cyborg de Auch!'
    end

    def eco(mensaje)
      "No entiendo \"#{mensaje}\". Acordate que los comandos van con una <code>/</code> adelante!"
    end
  end
end
