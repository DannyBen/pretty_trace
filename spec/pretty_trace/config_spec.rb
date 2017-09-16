require 'spec_helper'

describe Config do
  subject { described_class.instance }

  describe '#filter' do
    it "is defaults to []" do
      expect(subject.filter).to eq []
    end
  end

  describe '#ignore' do
    it "is has some default classes" do
      expect(subject.ignore).to include SystemExit
    end
  end

  describe '#range' do
    it "is defaults to nil" do
      expect(subject.range).to be nil
    end
  end

  describe '::from_hash' do
    let(:opts) { {filter: [/some_line/], ignore: [Interrupt]} }

    it "returns a config instance" do
      expect(described_class.from_hash opts).to be_a Config
    end

    it "assigns options to config" do
      expect(described_class.from_hash(opts).ignore).to eq [Interrupt]
      expect(described_class.from_hash(opts).filter).to eq [/some_line/]
    end
  end
end