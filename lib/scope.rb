class Scope
  attr_reader :context
  attr_reader :data

  # @param [Object] context
  # @param [Hash] kwargs
  # @return [Binding]
  def self.create(context, **kwargs)
    scope = new(context, **kwargs)
    scope.binding
  end

  # @param [Object] context
  # @param [Hash] kwargs
  def initialize(context, **kwargs)
    @context = context
    @data = kwargs
  end

  # @return [Binding]
  def binding
    super
  end

  # @param [Symbol] string
  # @param [Array<mixed>] args
  # @param [Block] block
  # @return [mixed]
  # @throws [NoMethodError]
  def method_missing(method, *args, &block)
    if context.respond_to?(method)
      context.send(method, *args, &block)
    elsif data.has_key?(method)
      data[method]
    else
      raise NoMethodError, "undefined method `#{method}` for #{self}"
    end
  end

  # @param [Symbol] method
  # @return [Boolean]
  def respond_to?(method)
    context.respond_to?(method) || data.has_key?(method)
  end
end
