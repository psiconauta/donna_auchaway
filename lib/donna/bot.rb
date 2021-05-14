# Este es el punto de entrada a la lógica de conexión con los servicios de
# Telegram y Discord. Donna recibe la configuración y los inicia, poniéndose a
# escuchar las consultas que van llegando. Cada API filtra los mensajes
# relevantes y los redirige a la clase que decide qué hacer con cada mensaje,
# independientemente del servicio.
require_relative 'api'

module Donna
  class Bot
    attr_accessor :config

    def initialize(config)
      @config = config
    end

    # TODO, Disparar los dos hilos, procesos, bots acá.
    def run!
      # Esconder esto
      Telegram::Bot::Client.run(config.telegram['key']) do |bot|
        # FIXME: Loguear más lindo.
        puts 'Donna Auchaway andando en Telegram'

        bot.listen do |event|
          API.new(event: event, bot: bot).process!
        end
      end
    end
  end
end
