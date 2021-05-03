# Hay que implementar como mínimo:
#
# https://core.telegram.org/bots#global-commands
#
require_relative 'api'

module Donna
  class Bot
    attr_accessor :telegram

    def initialize(telegram: {})
      @telegram = telegram

      unless @telegram[:key].nil?
        # TODO: No estoy seguro de que este sea el lugar correcto para esto.
        Telegram::Bot.configure do |config|
          config.adapter = :net_http_persistent
        end
      end
    end

    def run!
      # Esconder esto
      Telegram::Bot::Client.run(telegram[:key]) do |bot|
        # FIXME: Loguear más lindo.
        puts 'Donna Auchaway andando en Telegram'

        bot.listen do |message|
          API.new(message: message, bot: bot).process!
        end
      end
    end
  end
end
