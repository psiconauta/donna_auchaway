module Donna
  module API
    class Telegram
      attr_accessor :event, :bot, :log

      def initialize(event:, bot:, log:)
        @event = event
        @bot = bot
        @log = log
      end

      def responder!
        case event
        when ::Telegram::Bot::Types::Message
          log.debug "Mensaje: #{event.text}"
          pp event if log.level == Logger::DEBUG

          mensaje = Mensaje.new(usuarie: event.from.first_name)

          case event.text
          when '/start'
            bot.api.send_message chat_id: event.chat.id, text: mensaje.start
          when '/stop'
            bot.api.send_message chat_id: event.chat.id, text: mensaje.stop
          when '/about'
            bot.api.send_message chat_id: event.chat.id, text: mensaje.about
          else
            bot.api.send_message chat_id: event.chat.id, text: mensaje.eco(event.text)
          end
        when ::Telegram::Bot::Types::ChatMemberUpdated
        else
          log.error "Tipo no manejado: #{event.class}"
          pp event if log.level == Logger::DEBUG
        end
      end
    end
  end
end
