require 'spec_helper'

describe Handler do
  subject { described_class }

  context "when enabled" do
    # We must run this in an external ruby file because... REASONS!
    subject { "bundle exec ruby spec/fixtures/hell_raiser.rb" }

    it "catches all exceptions on exit" do
      expect(`#{subject}`).to match(/\nline.*\[32m.*\[0m.*\[36mfixtures.*\[35mhell_raiser/)
    end

    context "when the backtrace is empty" do
      subject { "bundle exec ruby spec/fixtures/filtered_hell_raiser.rb" }

      it "only shows the error" do
        expect(`#{subject}`).to eq "\n\e[34mRuntimeError\n\e[31mhell\e[0m\n"
      end
    end

    context "when debug_tip is on" do
      subject { "bundle exec ruby spec/fixtures/tipper.rb" }
      
      it "shows a friendly debug tip" do
        expect(`#{subject}`).to match %r{Run with .*PRETTY_TRACE=full.*for debug information}
      end
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

  describe '#debug_tip?' do
    it "returns false by default" do
      expect(subject.debug_tip?).to be false
    end

    context "when options[:debug_tip] is on" do
      before { subject.options[:debug_tip] = true }

      it "returns true" do
        expect(subject.debug_tip?).to be true
      end

      context "but when PRETTY_TRACE=full" do
        before { ENV['PRETTY_TRACE'] = 'full' }
        after  { ENV['PRETTY_TRACE'] = nil }
        
        it "returns false" do
          expect(subject.debug_tip?).to be false
        end
      end
    end
  end

end
