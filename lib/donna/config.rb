# Centraliza toda la configuración de les bots y demás.
module Donna
  class Config
    attr_accessor :c

    def initialize
      @c = YAML::load(IO.read('config.yml'))
    end

    def telegram_key
      ENV['TELEGRAM_API_KEY']
    end

    def telegram
      c['telegram'].merge('key' => telegram_key)
    end
  end
end
