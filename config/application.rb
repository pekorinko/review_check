require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ReviewCheck
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    #参考にしたURL：https://qiita.com/necojackarc/items/fb76352dbea5bdd83366#%E7%B5%90%E8%AB%96
    # config.autoload_paths << Rails.root.join("lib")

    # config.paths.add 'lib', eager_load: true 
    config.paths.add 'lib', eager_load: true
  end
end
