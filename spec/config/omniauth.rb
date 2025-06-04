require "logger"
require "omniauth"

logger = Logger.new($stdout)
OmniAuth.config.logger = logger
