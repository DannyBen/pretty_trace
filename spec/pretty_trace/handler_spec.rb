require 'spec_helper'

describe Handler do
  subject { described_class.instance }

  context "when enabled" do
    # We must run this in an external ruby file because... REASONS!
    subject { "bundle exec ruby spec/fixtures/hell_raiser.rb" }

    it "catches all exceptions on exit" do
      expect(`#{subject}`).to match(/\nline.*\[32m.*\[0m.*\[36mfixtures.*\[35mhell_raiser/)
    end
  end

  context "when disabled" do
    subject { "bundle exec ruby spec/fixtures/disabled_hell_raiser.rb" }

    it "raises exceptions normally" do
      expect(`#{subject} 2>&1`).to eq "spec/fixtures/disabled_hell_raiser.rb:2:in `<main>': hell (RuntimeError)\n"
    end

    it "exits with a non zero code" do
      system subject
      expect($?.exitstatus).to eq 1
    end
  end

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