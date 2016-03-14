# Require store engine dependencies before running test
require "redis"
require "dalli"

require "momm"

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end
