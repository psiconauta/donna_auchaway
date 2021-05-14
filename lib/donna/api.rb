module Donna
  class API
    attr_accessor :event, :bot

    def initialize(event:, bot:)
      @event = event
      @bot = bot
    end

    def process!
      case event
      when Telegram::Bot::Types::Message
        puts "Received: #{event.text}"
        puts "Received: #{event.class}"

        case event.text
        when '/start'
          bot.api.send_message chat_id: event.chat.id,
            text: "Hola #{event.from.first_name}"
        when '/stop'
          bot.api.send_message chat_id: event.chat.id,
            text: "Chau #{event.from.first_name}"
        when '/about'
          bot.api.send_message chat_id: event.chat.id,
            text: 'Soy Donna Auchaway. Mis pronombres son neutros (elle) y soy le cyborg de Auch!'
        else
          bot.api.send_message chat_id: event.chat.id,
            text: event.inspect
        end
      when Telegram::Bot::Types::ChatMemberUpdated
      else
        puts "Tipo no manejado"
        ap event
      end
    end
  end
end
