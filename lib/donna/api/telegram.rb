module Donna
  module API
    class Telegram
      attr_accessor :event, :bot

      def initialize(event:, bot:)
        @event = event
        @bot = bot
      end

      def responder!
        case event
        when ::Telegram::Bot::Types::Message
          puts "Received: #{event.text}"
          pp event

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
          puts "Tipo no manejado"
          puts "Received: #{event.class}"
          pp event
        end
      end
    end
  end
end
