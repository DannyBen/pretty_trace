require 'spec_helper'

describe Config do
  subject { Config.instance }

  describe '#filter' do
    it "is defaulted to []" do
      expect(subject.filter).to eq []
    end
  end
end