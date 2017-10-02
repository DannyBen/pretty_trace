require 'spec_helper'

describe Formatter do
  let(:backtrace) { [
    "file:1:in `method'", 
    "lib:2:in `method'",
    "lib:3:in `method'",
    "lib:4:in `method'"
  ]}

  let(:short_backtrace) { [
    "file:1:in `method'", 
    "lib:2:in `method'"
  ]}

  subject { described_class }

  describe '::pretty_trace' do
    it "returns an array of colored messages" do
      expect(subject.pretty_trace(backtrace).first).to eq "line \e[32m1   \e[0m in \e[36m\e[35mfile\e[0m > \e[34mmethod\e[0m"
    end
    
    context "with filter" do
      subject { described_class.pretty_trace backtrace, filter: /lib/ }

      it "obeys the provided options" do
        expect(subject.count).to be 1
        expect(subject.first).to match /file/
      end
    end

    context "with trim" do
      subject { described_class.pretty_trace backtrace }

      before do
        PrettyTrace.trim
      end

      after do
        PrettyTrace.no_trim
      end

      it "only keeps the first and last locations" do
        expect(subject.count).to be 3
        expect(subject[1]).to match /\(trimmed\)/
      end

      context "when backtrace is 3 locations or less" do
        subject { described_class.pretty_trace short_backtrace }

        it "does not trim" do
          expect(subject.count).to be 2
          expect(subject[1]).not_to match /\(trimmed\)/
        end        
      end

      context "with PRETTY_TRACE=full" do
        before do
          ENV['PRETTY_TRACE'] = 'full'
        end

        after do 
          ENV['PRETTY_TRACE'] = nil
        end

        it "temporarily disables trimming" do
          expect(subject.count).to be 4
          expect(subject[1]).not_to match /\(trimmed\)/
        end
      end
    end
  end

end