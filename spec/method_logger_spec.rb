require 'spec_helper'
require_relative '../lib/challenges/method_logger'

describe "Integration" do
  describe "with inherited instance methods" do
    before do
      ENV.store('COUNT_CALLS_TO', 'String#size')
    end

    let(:method_call) do
      (1..100).each { |i| i.to_s.size if i.odd? }
    end

    pending "counts calls successfully when ENV variable is set" do
      expect { method_call }.to output("String#size called 50 times").to_stdout
    end
  end

  describe "with included instance methods" do
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

    pending "counts calls successfully when ENV variable is set" do
      expect { method_call }.to output("B#foo called 10 times").to_stdout
    end
  end

  describe "with an instance method" do
    before do
      ENV.store('COUNT_CALLS_TO', 'Klass#some_method')
    end

    context "when public" do
      let(:method_call) do
        class Klass
          def some_method
          end
        end

        k = Klass.new

        10.times { k.some_method }
      end

      pending "counts calls successfully when ENV variable is set" do
        expect { method_call }.to output("Klass#some_method called 10 times").to_stdout
      end
    end

    context "when private" do
      before do
        ENV.store('COUNT_CALLS_TO', 'Klass#some_method')
      end

      let(:method_call) do
        class Klass
          private def some_method; end
        end

        k = Klass.new

        10.times { k.send(:some_method) }
      end

      pending "counts calls successfully when ENV variable is set" do
        expect { method_call }.to output("Klass#some_method called 10 times").to_stdout
      end
    end
  end

  describe "with a class method" do
    before do
      ENV.store('COUNT_CALLS_TO', 'Klass.some_method')
    end

    context "when public" do
      let(:method_call) do
        class Klass
          def self.some_method
          end
        end

        10.times { Klass.some_method }
      end

      pending "counts calls successfully when ENV variable is set" do
        expect { method_call }.to output("Klass.some_method called 10 times").to_stdout
      end
    end

    context "when private" do

      let(:method_call) do
        class Klass
          private
          def self.some_method
          end
        end

        10.times { Klass.send(:some_method) }
      end

      pending "counts calls successfully when ENV variable is set" do
        expect { method_call }.to output("Klass.some_method called 10 times").to_stdout
      end
    end
  end
end

describe Reporter do
  describe ".method_name_to_log" do
    before do
      ENV.store('COUNT_CALLS_TO', 'String#size')
    end

    it "returns a method and class from the ENV variable" do
      expect(Reporter.method_name_to_log).to eq([String, :size])
    end
  end

  describe ".report" do
    before do
      ENV.store('COUNT_CALLS_TO', 'String#size')
    end

    let(:expected_output) { "String#size was called 2 times.\n" }

    it "outputs the expected string" do
      expect { Reporter.report }.to output(expected_output).to_stdout
    end
  end
end

describe MethodLogger do
  describe "#add_method_logger" do
    let!(:test_class) do
      class TestClass
        extend MethodLogger

        def some_method
          :value
        end

        add_method_logger(:some_method)
      end
    end

    let(:class_instance)  { TestClass.new }
    let(:expected_output) { "TestClass#some_method was called 1 times.\n" }

    context "when the method exists" do
      it "replaces the method with a traced one" do
        expect(class_instance.some_method).to eq(:value)
      end

      it "still returns the result of the original" do
        expect(class_instance.some_method).to eq(:value)
      end
    end
  end
end
