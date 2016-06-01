module MethodLogger
  def add_call
    @call_count ||= 0
    @call_count += 1
  end

  def original_method_name(method_name)
    method_name.to_s
      .concat("_original")
      .to_sym
  end

  def logged_method_name(method_name)
    method_name.to_s
      .concat("_logged")
      .to_sym
  end

  def logged_method_exists?(method_name)
    false # for now
  end

  def define_logged_method(method_name)
    class_eval(
      "def #{logged_method_name(method_name)}(*args, &block);" +
      "  Reporter.add_call;" +
      "  #{original_method_name(method_name)}(*args, &block);" +
      "end"
    )
  end

  def add_method_logger(method_name)
    return unless method_defined?(method_name) ||
      class_method_defined?(method_name)

    #return if logged_method_exists?(method_name)

    define_logged_method(method_name)
    alias_method original_method_name(method_name), method_name
    alias_method method_name, logged_method_name(method_name)

    Reporter.report
  end

  # def method_visibility(method_name)
  #   if private_instance_methods.map{|s|s.to_sym}
  #     .include?(method_name.to_sym)
  #   :private
  #   elsif protected_instance_methods.map{ |s| s.to_sym }
  #     .include?(method_name.to_sym)
  #   :protected
  #   else
  #     :public
  #   end
  # end
end

module Reporter
  extend self

  attr_reader :call_count

  def add_call
    @call_count ||= 0
    @call_count += 1
  end

  def method_name_to_log
    @method_name_to_log ||= parse_method_name
  end

  def parse_method_name
    klass, method_name = ENV['COUNT_CALLS_TO'].split("#")
    [Kernel.const_get(klass), method_name.to_sym]
  end

  def report
    puts (ENV['COUNT_CALLS_TO'].to_s + call_count_string)
  end

  private

  def call_count_string
    case
    when call_count == 0 || call_count.nil?
      " was not called during execution."
    when call_count == 1
      " was called 1 time."
    when call_count > 1
      " was called #{call_count.to_s} times."
    end
  end
end
