require 'pretty_trace/version'
require 'pretty_trace/colors'
require 'pretty_trace/backtrace_item'
require 'pretty_trace/handler'
require 'pretty_trace/structured_backtrace'
require 'pretty_trace/module_methods'

require 'byebug' if ENV['BYEBUG']