require 'parsi-date'

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = [:should,:expect] }
  config.mock_with(:rspec) { |mocks| mocks.syntax = [:expect, :should] }
  config.run_all_when_everything_filtered = true
end
