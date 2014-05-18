
require 'singleton'
require 'yaml'

class AppConfig
  include Singleton

  RESOURCE_FILE = "./config/app_config.yml"

  def self.[](key)
    self.instance[key]
  end

  def [](key)
    load if @app_config == nil
    key = key.to_s if key.is_a?(Symbol)
    value = @app_config[key]
    return value
  end

  def load
    @app_config = YAML.load_file(RESOURCE_FILE)
  end
end
