# Centraliza toda la configuración de les bots y demás.
module Donna
  class Config
    attr_accessor :c, :log, :entorno
    cattr_accessor :instance

    def initialize(entorno:, logger:)
      @c = YAML::load(IO.read('config.yml'))[entorno]
      @log = logger
      @entorno = entorno

      # DEBUG < INFO < WARN < ERROR < FATAL < UNKNOWN
      logger.level = Object.const_get "Logger::#{c['log_level']}"

      @@instance = self
    end

    def telegram_key
      ENV['TELEGRAM_API_KEY']
    end

    # Mergeamos la API key a la configuración pública.
    def telegram
      c['telegram'].merge('key' => telegram_key)
    end

    # Devuelve la configuración de la DB en forma de método.
    def db
      c['db']
    end
  end
end
