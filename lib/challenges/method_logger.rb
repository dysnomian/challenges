require 'funtools/composition'

module MethodLogger
  # TODO handle bad strings
  class << self
    attr_reader :call_count

    def add_call
      @call_count ||= 0
      @call_count += 1
    end

    def method_name
      klass, method_name = ENV['COUNT_CALLS_TO'].split("#")
      [Kernel.const_get(klass), method_name.to_sym]
    end

    def report
      puts"#{ENV['COUNT_CALLS_TO']} was called " \
        "#{call_count.to_s} times."
    end
  end

  def clobber_method(class_and_method)
    klass, method_name = class_and_method
    m = Module.new(klass)
  end
end
