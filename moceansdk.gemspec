require File.expand_path('lib/moceansdk/version', File.dirname(__FILE__))

Gem::Specification.new do |s|
  s.name = 'moceansdk'
  s.version = Moceansdk::VERSION
  s.license = 'MIT'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Micro Ocean Technologies Sdn Bhd']
  s.email = ['support@moceanapi.com']
  s.homepage = 'https://github.com/MoceanAPI/mocean-sdk-ruby'
  s.description = 'Mocean SDK for Ruby'
  s.summary = 'This is a Mocean SDK written in Ruby, to use it you will need a mocean account. Signup for free at https://moceanapi.com'
  s.files = Dir.glob('lib/**/*.rb') + %w(LICENSE.txt README.md moceansdk.gemspec)
  s.required_ruby_version = '>= 2.2.0'
  s.add_dependency('hash_dot', '~> 2.4')
  s.add_dependency('http', '>= 3', '< 5')
  s.add_dependency('xml-simple', '~> 1.1')
  s.add_development_dependency('codecov', '>= 0.1.10')
  s.add_development_dependency('minitest', '~> 5.0')
  s.add_development_dependency('rake', '~> 12.0')
  s.require_path = 'lib'
  s.metadata = {
      'homepage' => 'https://github.com/MoceanAPI/mocean-sdk-ruby',
      'source_code_uri' => 'https://github.com/MoceanAPI/mocean-sdk-ruby'
  }
end