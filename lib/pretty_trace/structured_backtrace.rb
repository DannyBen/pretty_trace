module PrettyTrace
  class StructuredBacktrace
    attr_reader :options, :backtrace

    def initialize(backtrace, options = {})
      @options = options
      @backtrace = backtrace
    end

    def structure
      result = backtrace_list.map { |line| BacktraceItem.new line }
      if should_trim? result
        result.group_by(&:path).flat_map { |_, items| [items.first, items.last].uniq }
      else
        result
      end
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

    def backtrace_list
      result = backtrace.dup

      unless ENV['PRETTY_TRACE'] == 'full'
        filters.each do |expression|
          result.reject! { |trace| trace =~ expression }
        end
      end

      result.reverse
    end

    def filters
      result = options[:filter] || []
      result.is_a?(Array) ? result : [result]
    end

    def should_trim?(backtrace)
      options[:trim] and ENV['PRETTY_TRACE'] != 'full' and backtrace.size > 3
    end
  end
end
