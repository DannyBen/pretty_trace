module Nicetrace
  class Config
    include Singleton
    attr_accessor :filter

    def initialize
      self.filter = []
    end
  end
end