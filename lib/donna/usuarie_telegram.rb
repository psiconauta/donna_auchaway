# Decorador de Usuaries con comportamiento específico de Telegram.
class UsuarieTelegram
  attr_accessor :usuarie, :contexto

  # Todo lo que no esté implementado acá (búsquedas, etc) se le pasa a Usuarie.
  delegate_missing_to :usuarie

  def initialize(usuarie)
    self.contexto = :telegram
    self.usuarie = usuarie
  end

  def actualizar_perfil!(datos)
    self.telegram_username = datos.username
    self.telegram_data = datos

    save
  end

  def nombre
    telegram_data['first_name']
  end

  def username
    # El username es opcional en Telegram.
    "@#{telegram_username}" if telegram_username.present?
  end
end
