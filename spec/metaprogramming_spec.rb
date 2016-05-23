require 'spec_helper'
require_relative '../lib/challenges/metaprogramming'

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

describe ".method_name" do
  before do
    ENV.store('COUNT_CALLS_TO', 'String#size')
  end

  it "returns a method and class from the ENV variable" do
    expect(Metaprogramming.method_name).to eq([String, :size])
  end
end
