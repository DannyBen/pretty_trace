require 'colsole'

module Nicetrace
  module Rescue
    include Colsole
    def rescue_nicely(filter=[])
      return unless block_given?
      yield
    rescue Exception => e
      exception = NiceException.new e, filter
      exception.messages.each { |line| say line }  
    end
  end
end

include Nicetrace::Rescue