module Momm

  # Add Rails Engine to support assets pipeline
  module Rails
    class Engine < ::Rails::Engine
    end if defined?(::Rails)
  end
end