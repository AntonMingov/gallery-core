# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

Rack::Utils.multipart_part_limit = 2048
run Rails.application
Rails.application.load_server
