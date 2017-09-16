require 'spec_helper'

describe Config do
  subject { Config.instance }

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
end