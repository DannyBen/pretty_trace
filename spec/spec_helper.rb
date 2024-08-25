require 'simplecov'

unless ENV['NOCOV']
  SimpleCov.start do
    enable_coverage :branch if ENV['BRANCH_COV']
    coverage_dir 'spec/coverage'
  end
end

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

include PrettyTrace
PrettyTrace.disable

def fixture(filename, data = nil)
  if data
    File.write "spec/fixtures/#{filename}", data
    raise <<~WARNING
      Warning: Fixture data was written.
      This is perfectly fine if it was intended,
      but tests cannot proceed with it as a precaution.
    WARNING
  else
    File.read "spec/fixtures/#{filename}"
  end
end
