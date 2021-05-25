# Cargar librerías y entornos.
require 'bundler'
require 'yaml'
require 'logger'

entorno = ENV['DONNA_ENV'] || :development
Bundler.require(:default, entorno)

# Cargar punto de inicio.
require_relative 'lib/donna'

# Loguear en STDOUT para que systemd lo capture.
logger = Logger.new(STDOUT)
config = Donna::Config.new(entorno: entorno, logger: logger)

# Configurar bot de telegram.
Telegram::Bot.configure do |bot_config|
  bot_config.adapter = config.telegram['adapter'].to_sym
end

# Iniciar la conexión a la base de datos.
ActiveRecord::Base.establish_connection config.db
