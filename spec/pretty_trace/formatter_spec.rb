require 'spec_helper'

describe Formatter do
  let(:backtrace) { ["file:1:in `method'", "life:2:in `dothem'"] }

  subject { described_class }

  describe '::pretty_trace' do
    it "returns an array of colored messages" do
      expect(subject.pretty_trace backtrace).to eq ["line \e[32m1   \e[0m in \e[36m\e[35mfile\e[0m > \e[34mmethod\e[0m", "line \e[32m2   \e[0m in \e[36m\e[35mlife\e[0m > \e[34mdothem\e[0m"]
    end
    
    context "with filter" do
      subject { described_class.pretty_trace backtrace, filter: /life/ }

      it "obeys the provided options" do
        expect(subject.count).to be 1
        expect(subject.first).to match /file/
      end
    end
  end

end