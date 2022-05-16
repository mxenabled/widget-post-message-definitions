class PostMessageDefinition
  attr_reader :group
  attr_reader :subgroup
  attr_reader :label
  attr_reader :payload
  attr_reader :properties

  # @param [Hash] definitions
  # @return [Array<PostMessageDefinition>]
  def self.load(definitions)
    definitions.dig("post_messages").map do |group, subgroups|
      subgroups.map do |subgroup, messages|
        messages.map do |label, properties|
          payload = properties["payload"]
          properties.delete("payload")
          PostMessageDefinition.new(group, subgroup, label, payload, properties)
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
  # @param [Hash] payload (default: {}, example: {url: string})
  # @param [Hash] properties (default: {}, example: {warning: "This Post Message ..."})
  def initialize(group, subgroup, label, payload = {}, properties = {})
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
