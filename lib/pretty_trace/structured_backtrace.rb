module PrettyTrace
  class StructuredBacktrace
    attr_reader :options, :backtrace

    def initialize(backtrace, options={})
      @options = options
      @backtrace = backtrace
    end

    def structure
      result = backtrace.dup

      unless ENV['PRETTY_TRACE'] == 'full'
        filters.each do |expression|
          result.reject! { |trace| trace =~ expression }
        end
      end

      result.map! { |line| BacktraceItem.new line }
      first_line = result[0]
      result.reverse!
      result.uniq!(&:path) if should_trim? result

      if first_line and first_line.original_line != result[-1].original_line
        result.push first_line
      end

      result
    end

    def formatted_backtrace
      structure.map(&:formatted_line)
    end

    def to_s
      formatted_backtrace.join "\n"
    end

    def empty?
      formatted_backtrace.empty?
    end

  private

    def filters
      result = options[:filter] || []
      result.is_a?(Array) ? result : [result]
    end

    def should_trim?(backtrace)
      options[:trim] and ENV['PRETTY_TRACE'] != 'full' and backtrace.size > 3
    end
  end
end
