# Persona que quiere que Donna recuerde sus preferencias.
class Usuarie < ActiveRecord::Base
  validates :telegram_id, uniqueness: true

  # Pasamos el contexto para devolver la información relevante a Telegram o
  # Discord, según el caso.
  # TODO Separar en subclases que manejen el comportamiento relativo a cada
  # plataforma.
  attr_accessor :contexto

  def actualizar!(datos)
    case contexto
    when :telegram
      self.telegram_username = datos.username
      self.telegram_data = datos

      save
    else
      # Nada que hacer.
      true
    end
  end

  def nombre
    case contexto
    when :telegram
      telegram_data['first_name']
    else
      id
    end
  end

  def username
    case contexto
    when :telegram
      # El username es opcional en Telegram.
      "@#{telegram_username}" if telegram_username.present?
    else
      id
    end
  end

  # Permite encadenar el cambio de contexto.
  # TODO A futuro puede ser el método que devuelva una subclase según la
  # TODO plataforma, para abstraer la llamada del resto del código.
  def en_contexto(contexto)
    self.contexto = contexto

    return self
  end
end
