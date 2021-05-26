# La gente que quiere que Donna recuerde sus preferencias.
class Usuarie < ActiveRecord::Base
  validates :telegram_id, uniqueness: true

  def actualizar_desde_telegram!(datos)
    self.telegram_username = datos.username
    self.telegram_data = datos

    save
  end
end
