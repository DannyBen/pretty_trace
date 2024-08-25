require 'spec_helper'

describe StructuredBacktrace do
  subject { described_class.new backtrace }

  let(:backtrace) do
    [
      "lib:4:in `seven'",
      "lib:3:in `six'",
      "lib:2:in `five'",
      "lib:1:in `four'",
      "file:3:in `three'",
      "file:2:in `two'",
      "file:1:in `one'",
    ]
  end

  let(:short_backtrace) do
    [
      "lib:2:in `method'",
      "file:1:in `method'",
    ]
  end

  describe '#structure' do
    it 'returns a reversed array of BacktraceItems' do
      expect(subject.structure).to be_an Array
      expect(subject.structure.first).to be_a BacktraceItem
      expect(subject.structure.first.method).to eq 'one'
    end

    context 'with filter' do
      subject { described_class.new backtrace, filter: /lib/ }

      it 'removes all matching lines' do
        expect(subject.structure.count).to be 3
        expect(subject.structure.first.path).to eq 'file'
      end
    end

    context 'when backtrace is empty' do
      subject { described_class.new short_backtrace, filter: [/lib/, /file/] }

      it 'returns an empty array' do
        expect(subject.structure).to eq []
      end
    end

    context 'with trim' do
      subject { described_class.new backtrace, trim: true }

      it 'keeps the first and the last line of each file' do
        expect(subject.structure.count).to be 4
        expect(subject.structure[0].method).to eq 'one'
        expect(subject.structure[1].method).to eq 'three'
        expect(subject.structure[2].method).to eq 'four'
        expect(subject.structure[3].method).to eq 'seven'
      end

      context 'when backtrace is 3 locations or less' do
        subject { described_class.new short_backtrace, trim: true }

        it 'does not trim' do
          expect(subject.structure.count).to be 2
        end
      end

      context 'with PRETTY_TRACE=full' do
        before do
          ENV['PRETTY_TRACE'] = 'full'
        end

        after do
          ENV['PRETTY_TRACE'] = nil
        end

        it 'temporarily disables trimming' do
          expect(subject.structure.count).to be 7
        end
      end
    end

    context 'with reverse' do
      subject { described_class.new backtrace, reverse: true }

      it 'shows the first file last' do
        expect(subject.structure[0].method).to eq 'seven'
        expect(subject.structure[6].method).to eq 'one'
      end
    end
  end

  describe '#empty?' do
    context 'when there is a backtrace' do
      it 'returns false' do
        expect(subject.empty?).to be false
      end
    end

    context 'when there is no backtrace' do
      subject { described_class.new short_backtrace, filter: [/lib/, /file/] }

      it 'returns true' do
        expect(subject.empty?).to be true
      end
    end
  end

  describe '#formatted_backtrace' do
    it 'returns an array of color highlighted strings' do
      expect(subject.formatted_backtrace).to be_an Array
      expect(subject.formatted_backtrace.join("\n"))
        .to match_approval('structured_backtrace/formatted_backtrace')
    end
  end

  describe '#to_s' do
    it 'returns a merged formatted_backtrace' do
      expect(subject.to_s).to be_a String
      expect(subject.to_s).to match_approval('structured_backtrace/to_s')
    end
  end
end
