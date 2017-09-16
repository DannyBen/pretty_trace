require 'spec_helper'

describe PrettyException do
  let(:backtrace) { ["file:1:in `method'", "life:2:in `dothem'"] }

  let(:exception) {
    Exception.new('My Bad...').tap do |e|
      e.set_backtrace backtrace
    end
  }
  
  subject { described_class.new exception }

  describe '#messages' do
    it "returns colsole-formatted array of messages" do
      expect(subject.messages).to eq ["line !bldgrn!1   !txtrst! in !txtcyn!!bldpur!file!txtrst! > !txtblu!method", "line !bldgrn!2   !txtrst! in !txtcyn!!bldpur!life!txtrst! > !txtblu!dothem", "\n", "!undgrn!Exception", "!txtred!My Bad...", "\n"]
    end
  end

  context "with a backtrace argument" do
    subject { described_class.new backtrace }

    describe '#messages' do
      it "returns colsole-formatted array of messages" do
        expect(subject.messages).to eq ["line !bldgrn!1   !txtrst! in !txtcyn!!bldpur!file!txtrst! > !txtblu!method", "line !bldgrn!2   !txtrst! in !txtcyn!!bldpur!life!txtrst! > !txtblu!dothem"]
      end
    end
  end

  context "with the optional opts argument" do
    let(:opts) { {range: 0..0} }
    subject { described_class.new backtrace, opts }

    it "obeys the provided options" do
      expect(subject.messages.count).to eq 1
    end
  end
end