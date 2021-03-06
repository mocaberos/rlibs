# frozen_string_literal: true

require_relative 'lib/moca_rlibs/version'

Gem::Specification.new do |spec|
  spec.name          = 'moca_rlibs'
  spec.version       = MocaRlibs::VERSION
  spec.authors       = ['mocaberos']
  spec.email         = ['mocaberos@gmail.com']

  spec.summary       = 'A toolset for ruby and rails.'
  spec.description   = 'A toolset for ruby and rails.'
  spec.homepage      = 'https://github.com/mocaberos/rlibs'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/mocaberos/rlibs'
  spec.metadata['changelog_uri'] = 'https://github.com/mocaberos/rlibs/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activemodel'
  spec.add_dependency 'activerecord'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'email_validator'
  spec.add_dependency 'grape'
  spec.add_dependency 'slack-notifier', '~> 2.4.0'

  spec.add_development_dependency 'codecov'
  spec.add_development_dependency 'rack'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rails'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'sqlite3'

  spec.metadata = {
    'rubygems_mfa_required' => 'true'
  }
end
