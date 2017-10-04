require 'spec_helper'

describe Handler do
  let(:exception) { raise 'hell' }
  subject { described_class.instance }

  describe '#enable' do
    before do
      allow(subject).to receive :at_exit
      subject.disable
      expect(subject).not_to be_enabled
    end

    it "enables" do
      subject.enable
      expect(subject).to be_enabled
    end

    it "registers an 'at_exit' handler" do
      expect(subject).to receive :at_exit
      subject.enable
    end
  end

  describe '#disable' do
    before do
      allow(subject).to receive :at_exit
      subject.enable
      expect(subject).to be_enabled
    end

    it "disables" do
      subject.disable
      expect(subject).not_to be_enabled
    end
  end

  describe '#options' do
    it "returns default options" do
      expect(subject.options).to be_a Hash
      expect(subject.options[:filter]).to be_an Array
    end
  end

  describe '#options=' do
    it "stores options" do
      subject.options = { some: 'option' }
      expect(subject.options).to eq some: 'option'
    end
  end


end