# La gente que quiere que Donna recuerde sus preferencias.
class Usuarie < ActiveRecord::Base
  validates :telegram_id, uniqueness: true

  def actualizar_desde_telegram!(datos)
    self.telegram_username = datos.username
    self.telegram_data = datos

    save
  end

  # Pasamos el contexto para devolver la información relevante a telegram o
  # discord, según el caso.
  def nombre(contexto = nil)
    case contexto
    when :telegram
      telegram_data['first_name']
    else
      id
    end
  end

  def username(contexto = nil)
    case contexto
    when :telegram
      "@#{telegram_username}"
    else
      id
    end
  end
end
