require 'thread_variable'

RSpec.configure do |config|
  config.color_enabled = true

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
