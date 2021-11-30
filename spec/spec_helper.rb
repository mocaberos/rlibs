# frozen_string_literal: true

require 'simplecov'
require 'codecov'
require 'rack/test'
require 'sqlite3'
require 'active_record'
require 'active_record/base'
require 'active_record/migration'
require 'moca_rlibs'

ActiveRecord::Migration.verbose = false
ActiveRecord::Base.establish_connection(
  'adapter'  => 'sqlite3',
  'database' => ':memory:'
)

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
