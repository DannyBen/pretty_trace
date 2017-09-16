lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'date'
require 'pretty_trace/version'

Gem::Specification.new do |s|
  s.name        = 'pretty_trace'
  s.version     = PrettyTrace::VERSION
  s.date        = Date.today.to_s
  s.summary     = "Pretty backtrace and error messages"
  s.description = "Display clean and colorful error messages and backtrace"
  s.authors     = ["Danny Ben Shitrit"]
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.homepage    = 'https://github.com/DannyBen/pretty_trace'
  s.license     = 'MIT'
  s.required_ruby_version = ">= 2.0.0"

  s.add_development_dependency 'runfile', '~> 0.10'
  s.add_development_dependency 'runfile-tasks', '~> 0.4'
  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'simplecov', '~> 0.15'
  s.add_development_dependency 'byebug', '~> 9.0'
end
