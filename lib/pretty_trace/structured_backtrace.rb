module PrettyTrace
  class StructuredBacktrace
    attr_reader :options, :backtrace

    def initialize(backtrace, options={})
      @options = options
      @backtrace = backtrace
    end

    def structure
      filter = options[:filter] || []
      filter = [filter] unless filter.is_a? Array

      result = backtrace.dup

      filter.each do |expression|
        result.reject! { |trace| trace =~ expression }
      end

      result.map! { |line| BacktraceItem.new line }
      first_line = result[0]
      result.reverse!
      result.uniq!(&:path) if should_trim? result

      result.push first_line unless first_line.original_line == result[-1].original_line

      result
    end

    def formatted_backtrace
      structure.map(&:formatted_line)
    end

    def to_s
      formatted_backtrace.join "\n"
    end

    private

    def should_trim?(backtrace)
      options[:trim] and ENV['PRETTY_TRACE'] != 'full' and backtrace.size > 3
    end
  end
end
