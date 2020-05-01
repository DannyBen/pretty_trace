require 'spec_helper'

describe PrettyTrace do
  let(:handler) { Handler.instance }
  subject { described_class }
  
  describe '::enable' do
    it "enables the handler instance" do
      expect(handler).to receive :enable
      subject.enable
    end
  end

  describe '::disable' do
    it "disables the handler instance" do
      expect(handler).to receive :disable
      subject.disable
    end
  end

  describe '::trim' do
    before do 
      handler.options = {}
    end

    it "enables trimming" do
      subject.trim
      expect(handler.options[:trim]).to be true
    end
  end

  describe '::no_trim' do
    before do 
      handler.options = { trim: true }
    end

    it "disables trimming" do
      subject.no_trim
      expect(handler.options[:trim]).to be false
    end
  end

  describe '::debug_tip' do
    it "enables debug tip" do
      subject.debug_tip
      expect(handler.options[:debug_tip]).to be true
    end
  end

  describe '::no_debug_tip' do
    before do 
      handler.options = { debug_tip: true }
    end

    it "disabled debug tip" do
      subject.no_debug_tip
      expect(handler.options[:debug_tip]).to be false
    end
  end

  describe '::filter' do
    before do
      handler.options = { filter: [/default/] }
    end

    context "with an array" do
      let(:new_filter) { [/one mississippi/, /two mississippi/] }

      it "appends the array to the handler's filter" do
        subject.filter new_filter
        expect(handler.options[:filter]).to eq [/default/] + new_filter
      end
    end

    context "with a regex" do
      let(:new_filter) { /one mississippi/ }

      it "adds the regex to the handler's filter" do
        subject.filter new_filter
        expect(handler.options[:filter]).to eq [/default/, new_filter]
      end
    end
  end

end