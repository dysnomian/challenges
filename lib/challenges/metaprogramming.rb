require 'funtools/composition'

module Metaprogramming
  class << self

    # TODO: handle bad strings
    def method_name
      klass, method_name = ENV['COUNT_CALLS_TO'].split("#")
      [Kernel.const_get(klass), method_name.to_sym]
    end

    def clobber_method(class_and_method)
      klass, method_name = class_and_method
      Class.new(klass)
    end

  end
end
