require 'spec_helper'
require_relative '../lib/challenges/method_logger'

describe "Integration" do
  describe "with String#size" do
    before do
      ENV.store('COUNT_CALLS_TO', 'String#size')
    end

    let(:method_call) do
      (1..100).each { |i| i.to_s.size if i.odd? }
    end

    it "counts calls successfully when ENV variable is set" do
      expect(method_call).to output("String#size called 50 times").to_stdout
    end
  end
end

describe "with B#foo" do
  before do
    ENV.store('COUNT_CALLS_TO', 'B#foo')
  end

  let(:method_call) do
    module A
      def foo
      end
    end

    class B
      include A
    end

    10.times { B.new.foo }
  end

  it "counts calls successfully when ENV variable is set" do
    expect(method_call).to output("B#foo called 10 times")
  end
end

describe MethodLogger do
  describe ".method_name" do
    before do
      ENV.store('COUNT_CALLS_TO', 'String#size')
    end

    it "returns a method and class from the ENV variable" do
      expect(MethodLogger.method_name).to eq([String, :size])
    end
  end

  describe ".report" do
    before do
      MethodLogger.add_call
      MethodLogger.add_call
      ENV.store('COUNT_CALLS_TO', 'String#size')
    end

    let(:expected_output) { "String#size was called 2 times.\n" }

    it "outputs the expected string" do
      expect { MethodLogger.report }.to output(expected_output).to_stdout
    end
  end
end
