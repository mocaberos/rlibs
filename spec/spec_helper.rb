# frozen_string_literal: true

require 'simplecov'
require 'codecov'
require 'rack/test'
require 'moca_rlibs'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  SimpleCov.formatter = SimpleCov::Formatter::Codecov if ENV['CODECOV_TOKEN']
  SimpleCov.start
end
