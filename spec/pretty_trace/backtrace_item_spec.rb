require 'spec_helper'

describe BacktraceItem do
  let(:line) { "dir/subdir/file.rb:777:in `method'" }
  let(:bad_line) { "some exceptions with bad style" }
  subject { BacktraceItem.new line }

  describe '#formatted?' do
    it "returns true" do
      expect(subject.formatted?).to be true
    end

    context "with a badly formatted line" do
      subject { BacktraceItem.new bad_line }

      it "returns false" do
        expect(subject.formatted?).to be false
      end
    end
  end

  describe '#formatted_line' do
    it "returns color coded line" do
      expect(subject.formatted_line).to match /line.*\[32m777/
    end

    context "with a badly formatted line" do
      subject { BacktraceItem.new bad_line }

      it "returns the original line" do
        expect(subject.formatted_line).to eq subject.original_line
      end
    end
  end

  describe '#original_line' do
    it "returns original_line" do
      expect(subject.original_line).to eq line
    end
  end

  describe '#path' do
    it "returns path" do
      expect(subject.path).to eq 'dir/subdir/file.rb'
    end
  end

  describe '#file' do
    it "returns file" do
      expect(subject.file).to eq 'file.rb'
    end
  end

  describe '#line' do
    it "returns line" do
      expect(subject.line).to eq '777'
    end
  end

  describe '#dir' do
    it "returnsdir " do
      expect(subject.dir).to eq 'subdir/'
    end
  end

  describe '#method' do
    it "returns method" do
      expect(subject.method).to eq 'method'
    end
  end

  describe '#full_dir' do
    it "returns full_dir" do
      expect(subject.full_dir).to eq 'dir/subdir'
    end
  end

end