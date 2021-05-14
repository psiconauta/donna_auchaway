# Centraliza toda la configuración de les bots y demás.
module Donna
  class Config
    attr_accessor :c, :log

    def initialize(entorno:, logger:)
      @c = YAML::load(IO.read('config.yml'))[entorno]

      # DEBUG < INFO < WARN < ERROR < FATAL < UNKNOWN
      logger.level = Object.const_get "Logger::#{c['log_level']}"
      @log = logger
    end

    def telegram_key
      ENV['TELEGRAM_API_KEY']
    end

    def telegram
      c['telegram'].merge('key' => telegram_key)
    end
  end
end
