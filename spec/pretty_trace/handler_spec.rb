require 'spec_helper'

describe Handler do
  subject { described_class.instance }

  describe '#trace_point' do
    it "returns a TracePoint object" do
      expect(subject.trace_point).to be_a TracePoint
    end

    context "when enabled" do
      before do
        subject.trace_point.enable
      end

      after do
        subject.trace_point.disable
      end

      it "is called on exception" do
        expect_any_instance_of(PrettyException).to receive(:messages)
        expect{raise 'birthday chair'}.to raise_error(Exception)
      end
    end
  end

end