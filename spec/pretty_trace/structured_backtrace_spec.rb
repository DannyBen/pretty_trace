require 'spec_helper'

describe StructuredBacktrace do
  let(:backtrace) { [
    "file:1:in `one'", 
    "file:2:in `two'", 
    "file:3:in `three'", 
    "lib:1:in `four'",
    "lib:2:in `five'",
    "lib:3:in `six'",
    "lib:4:in `seven'"
  ]}

  let(:short_backtrace) { [
    "file:1:in `method'", 
    "lib:2:in `method'"
  ]}

  subject { described_class.new backtrace }

  describe '#structure' do
    it "returns a reversed array of BacktraceItems" do
      expect(subject.structure).to be_an Array
      expect(subject.structure.first).to be_a BacktraceItem
      expect(subject.structure.first.method).to eq 'seven'
    end

    context "with filter" do
      subject { described_class.new backtrace, filter: /lib/ }

      it "removes all matching lines" do
        expect(subject.structure.count).to be 3
        expect(subject.structure.first.path).to eq 'file'
      end
    end    

    context "with trim" do
      subject { described_class.new backtrace, trim: true }

      it "keeps the very first line and the last line of each file" do
        expect(subject.structure.count).to be 3
        expect(subject.structure[0].method).to eq 'seven'
        expect(subject.structure[1].method).to eq 'three'
        expect(subject.structure[2].method).to eq 'one'
      end

      context "when backtrace is 3 locations or less" do
        subject { described_class.new short_backtrace, trim: true }

        it "does not trim" do
          expect(subject.structure.count).to be 2
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
          expect(subject.structure.count).to be 7
        end
      end
    end
  end

  describe '#formatted_backtrace' do
    it "returns an array of color highlighted stings" do
      expect(subject.formatted_backtrace).to be_an Array
      expect(subject.formatted_backtrace.first).to match(/line.*\[32m4.*\[0m.*\[36m.*\[35mlib.*\[0m.*\[34mseven.*\[0m/)
    end
  end

  describe '#to_s' do
    it "returns a merged formatted_backtrace" do
      expect(subject.to_s).to be_a String
      expect(subject.to_s).to match(/line.*\[32m4.*\[0m/)
    end
  end

end