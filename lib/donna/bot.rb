# Este es el punto de entrada a la lógica de conexión con los servicios de
# Telegram y Discord. Donna recibe la configuración y los inicia, poniéndose a
# escuchar las consultas que van llegando. Cada API filtra los mensajes
# relevantes y los redirige a Mensaje, que decide qué hacer independientemente
# del servicio.
require_relative 'mensaje'
require_relative 'usuarie'
require_relative 'api/telegram'

module Donna
  class Bot
    attr_accessor :config

    def initialize(config)
      @config = config
    end

    # TODO, Disparar los dos hilos, procesos, bots acá.
    def run!
      # Esconder esto
      ::Telegram::Bot::Client.run(config.telegram['key']) do |bot|
        config.log.info 'Donna escuchando en Telegram'

        bot.listen do |event|
          API::Telegram.new(event: event, bot: bot, log: config.log).responder!
        end
      end
    rescue ::Telegram::Bot::Exceptions::ResponseError => e
      config.log.error e
    end
  end
end
