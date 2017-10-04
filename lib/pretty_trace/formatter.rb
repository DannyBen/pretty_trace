module PrettyTrace
  class Formatter
    def self.pretty_trace(backtrace, opts={})
      filter = opts[:filter] || []
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

      result.map(&:formatted_line)
    end

    def self.should_trim?(backtrace)
      ENV['PRETTY_TRACE_TRIM'] and ENV['PRETTY_TRACE'] != 'full' and
        backtrace.size > 3
    end
  end
end
