# Acá se maneja lo específicamente relacionado con recibir y responder mensajes
# de Telegram.
module Donna
  module API
    class Telegram
      MENSAJE_REGEX = /(?<comando>\/\w+)@?(?<botname>\w+)?\s*(?<parametro>.*)/

      attr_accessor :event, :bot, :log, :comando, :botname, :parametro

      def initialize(event:, bot:, log:)
        @event = event
        @bot = bot
        @log = log
      end

      def responder!
        usuarie = Usuarie.find_or_initialize_by(telegram_id: event.from.id).en_contexto(:telegram)
        usuarie.actualizar! event.from

        mensaje = Mensaje.new usuarie: usuarie

        log.debug "Usuarie #{usuarie.username || usuarie.nombre} guardadx" if usuarie.persisted?
        pp usuarie.telegram_data if log.level == Logger::DEBUG

        case event
        when ::Telegram::Bot::Types::Message
          parsear_mensaje!
          return unless mensaje_nuestro?

          log.debug "Mensaje: #{event.text}"
          pp event if log.level == Logger::DEBUG

          # Opciones default para todas las respuestas.
          opciones = {
            chat_id: event.chat.id,
            parse_mode: 'HTML'
          }

          case comando
          when '/start'
            bot.api.send_message opciones.merge(text: mensaje.start)
          when '/stop'
            bot.api.send_message opciones.merge(text: mensaje.stop)
          when '/help'
            bot.api.send_message opciones.merge(text: mensaje.help)
          when '/pronombres'
            botones = []
            # Agrupamos las opciones de a 3.
            mensaje.opciones_para_pronombres.each_slice(3) do |grupo|
              fila_de_botones = grupo.map do |opcion|
                ::Telegram::Bot::Types::InlineKeyboardButton.new(
                  text: opcion,
                  callback_data: "pronombres:#{opcion}"
                )
              end
              botones << fila_de_botones
            end

            teclado = ::Telegram::Bot::Types::InlineKeyboardMarkup.new(
              inline_keyboard: botones
            )

            bot.api.send_message chat_id: event.chat.id, text: mensaje.pronombres,
              reply_markup: teclado
          when '/contame_de'
            username = parametro.split('@').last

            respuesta = if username == Donna::Config.instance.botname(:telegram)
              mensaje.about
            else
              alguien = Usuarie.where('lower(telegram_username) = ?', username.downcase).first

              mensaje.contame_de(alguien)
            end

            bot.api.send_message opciones.merge(text: respuesta)
          when '/about'
            bot.api.send_message opciones.merge(text: mensaje.about)
          else
            bot.api.send_message opciones.merge(text: mensaje.eco(event.text))
          end
        # Acá se manejan las respuestas de les usuaries.
        when ::Telegram::Bot::Types::CallbackQuery
          log.debug "Callback: #{event.data}"
          pp event if log.level == Logger::DEBUG

          dato, valor = event.data.split(':')

          case dato
          when 'pronombres'
            bot.api.send_message chat_id: event.from.id, text: mensaje.respuesta_pronombres(valor)
          else
            log.error "Mensaje no manejado: #{dato}"
          end
        when ::Telegram::Bot::Types::ChatMemberUpdated
        else
          log.error "Tipo no manejado: #{event.class}"
          pp event if log.level == Logger::DEBUG
        end
      end

      # Donna necesita entender comandos sueltos ('comando'), o que incluyen su
      # nombre ('botname'), y también cuando el comando pregunta por une
      # usuarie o mande información ('parametro'):
      #
      #   /start@donna_auchaway_bot algo
      #
      def parsear_mensaje!
        log.debug "API::Telegram.parsear_mensaje! - #{event.text}"

        if (event.text && resultados = event.text.match(MENSAJE_REGEX))
          @comando = resultados[:comando]
          @botname = resultados[:botname]
          @parametro = resultados[:parametro]
        end
      end

      # Cuando Donna está en un grupo, los mensajes pueden venir con su @
      # incluida.
      def mensaje_nuestro?
        log.debug "API::Telegram.mensaje_nuestro?"

        botname.nil? || botname == Donna::Config.instance.botname(:telegram)
      end
    end
  end
end
