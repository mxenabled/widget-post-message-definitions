class PostMessageDefinition
  attr_reader :group
  attr_reader :subgroup
  attr_reader :label
  attr_reader :payload
  attr_reader :properties

  class PayloadField
    attr_reader :name, :type

    # @param [String] name
    # @param [String | Array | Hash] type
    # @param [Hash] properties (default: {}, example: {required: false})
    def initialize(name, type, properties = {})
      @name = name
      @type = type
      @properties = properties
    end
  end

  # @param [Hash] definitions
  # @return [Array<PostMessageDefinition>]
  def self.load(definitions)
    definitions.dig("post_messages").map do |group, subgroups|
      subgroups.map do |subgroup, messages|
        messages.map do |label, raw_properties|
          message_properties = raw_properties.except("payload")
          payload = raw_properties["payload"].each_with_object([]) do |(name, value), acc|
            (type, field_properties) = if value.is_a?(Hash) && !value["type"].nil?
                                         [value.dig("type"), value.except("type")]
                                       else
                                         [value, {}]
                                       end
            acc << PayloadField.new(name, type, field_properties)
          end

          PostMessageDefinition.new(group, subgroup, label, payload, message_properties)
        end
      end.flatten
    end.flatten
  end

  # @param [String] file_path
  # @return [Array<PostMessageDefinition>]
  def self.load_file(file_path)
    load(YAML.load_file(file_path))
  end

  # @param [Symbol] group (eg, :entities, :widgets)
  # @param [Symbol] subgroup (eg, :generic, :connect)
  # @param [Symbol] label (eg, :submitMFA, :overdraftWarning/cta/transferFunds)
  # @param [Array<PayloadField>] payload (default: [])
  # @param [Hash] properties (default: {}, example: {warning: "This Post Message ..."})
  def initialize(group, subgroup, label, payload = [], properties = {})
    @group = group.to_sym
    @subgroup = subgroup.to_sym
    @label = label.to_sym
    @payload = payload
    @properties = properties
  end

  # @return [String]
  def to_s
    grouped? ? "mx/#{subgroup}/#{label}" : "mx/#{label}"
  end

  # @return [Boolean]
  def grouped?
    !generic?
  end

  # @return [Boolean]
  def generic?
    subgroup == :generic
  end

  # @return [Boolean]
  def entity?
    group == :entity
  end
end
