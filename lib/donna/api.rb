module Donna
  class API
    attr_accessor :message, :bot

    def initialize(message:, bot:)
      @message = message
      @bot = bot
    end

    def process!
      puts "Received: #{message.text}"

      case message.text
      when '/start'
        bot.api.send_message chat_id: message.chat.id, text: "Hola #{message.from.first_name}"
      when '/stop'
        bot.api.send_message chat_id: message.chat.id, text: "Chau #{message.from.first_name}"
      when '/about'
        bot.api.send_message chat_id: message.chat.id, text: 'Soy Donna Auchaway. Mis pronombres son neutros (elle) y soy le cyborg de Auch!'
      else
        bot.api.send_message chat_id: message.chat.id, text: message.inspect
      end
    end
  end
end
