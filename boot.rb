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
c = Donna::Config.new(entorno: entorno, logger: logger)

c.log.info "Donna despertando en modo #{entorno}"
