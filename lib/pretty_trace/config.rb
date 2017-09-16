require 'singleton'

module PrettyTrace
  class Config
    include Singleton
    attr_accessor :filter, :ignore, :range

    def initialize
      self.filter = []
      self.ignore = [SystemExit]
      self.range = nil
    end

    def self.from_hash(opts)
      instance.tap do |i|
        i.filter << opts[:filter] if opts[:filter]
        i.ignore << opts[:ignore] if opts[:ignore]
        i.range = opts[:range] if opts[:range]
      end
    end
  end
end