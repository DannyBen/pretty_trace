lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pretty_trace/version'

Gem::Specification.new do |s|
  s.name        = 'pretty_trace'
  s.version     = PrettyTrace::VERSION
  s.summary     = 'Pretty backtrace and error messages'
  s.description = 'Display clean and colorful error messages and backtrace'
  s.authors     = ['Danny Ben Shitrit']
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.homepage    = 'https://github.com/DannyBen/pretty_trace'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 2.6.0'

  s.metadata['rubygems_mfa_required'] = 'true'
end
