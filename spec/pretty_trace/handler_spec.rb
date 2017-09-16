require 'spec_helper'

describe Handler do
  subject { described_class.instance }
  
  let(:exception) { raise 'hell' }

  describe '#trace_point' do
    it "returns a TracePoint object" do
      expect(subject.trace_point).to be_a TracePoint
    end

    context "when disabled" do
      it "raises unaltered exceptions" do
        subject.trace_point.disable do
          begin
            exception
          rescue Exception => e
            expect(e.backtrace).to be_an Array
            expect(e.backtrace.first).not_to match /\e\[32m/
            expect(e.backtrace.first).to match /handler_spec.rb/
          end
        end
      end
    end

    context "when enabled" do
      it "formats the exception's backtrace" do
        subject.trace_point.enable do
          begin
            exception
          rescue Exception => e
            expect(e.backtrace).to be_an Array
            expect(e.backtrace.first).to match /\e\[32m.*handler_spec.rb\e\[0m/
          end
        end
      end
    end
  end

end