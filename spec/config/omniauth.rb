require "logger"
require "omniauth"

logger = Logger.new(STDOUT)
OmniAuth.config.logger = logger