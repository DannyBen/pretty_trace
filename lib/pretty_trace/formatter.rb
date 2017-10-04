module PrettyTrace
  class Formatter
    def self.pretty_trace(backtrace, opts={})
      filter = opts[:filter] || []
      filter = [filter] unless filter.is_a? Array

      filter.each do |expression|
        backtrace.reject! { |trace| trace =~ expression }
      end

      backtrace.map! { |line| BacktraceItem.new line }
      backtrace.reverse!.uniq!(&:path).reverse! if should_trim? backtrace
      backtrace.map(&:formatted_line)
    end

    def self.should_trim?(backtrace)
      ENV['PRETTY_TRACE_TRIM'] and ENV['PRETTY_TRACE'] != 'full' and
        backtrace.size > 3
    end
  end
end
