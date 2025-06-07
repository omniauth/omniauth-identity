require "logger"
require "omniauth"

if OmniAuth.config.respond_to?(:logger=)
  logger = Logger.new($stdout)
  OmniAuth.config.logger = logger
end
