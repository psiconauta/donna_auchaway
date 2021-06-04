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
      ENV['DONNA_TELEGRAM_API_KEY']
    end

    def telegram_botname
      ENV['DONNA_TELEGRAM_BOTNAME']
    end

    # Mergeamos la API key a la configuración pública.
    def telegram
      c['telegram'].merge({
        'key' => telegram_key,
        'botname' => telegram_botname
      })
    end

    # Devuelve la configuración de la DB en forma de método.
    def db
      c['db']
    end
  end
end
