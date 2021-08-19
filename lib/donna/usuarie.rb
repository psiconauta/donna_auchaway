# Persona que quiere que Donna recuerde sus preferencias.
require_relative 'usuarie_telegram'

class Usuarie < ActiveRecord::Base
  validates :telegram_id, uniqueness: true

  # Pasamos el contexto para devolver la información relevante a Telegram o
  # Discord, según el caso.
  def en_contexto(contexto)
    case contexto
    when :telegram
      UsuarieTelegram.new self
    end
  end
end
