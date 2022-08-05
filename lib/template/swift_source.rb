class Template::SwiftSource < Template::Base
  using StringRefinement

  # cspell: disable
  CONTENT = <<-CONTENT
    |public protocol Event {}
    |<% post_message_definitions_by_subgroup.each do |subgroup, post_message_definitions| %>
    |public enum <%= event_group_type_name(post_message_definitions.first) %> {
    |    <%- post_message_definitions.each do |post_message| -%>
    |    public struct <%= payload_type_name(post_message) %>: Event {
    |        <%- post_message.payload.each do |field| -%>
    |        <%- if field.optional? -%>
    |        public let <%= payload_property_name(field) %>: <%= payload_property_type(post_message, field) %>?
    |        <%- else -%>
    |        public let <%= payload_property_name(field) %>: <%= payload_property_type(post_message, field) %>
    |        <%- end -%>
    |        <%- end -%>
    |    }
    |    <%- end -%>
    |}
    |<%- end -%>
    |
    |<%- post_message_definitions.each do |post_message| -%>
    |<%- post_message.payload.each do |field| -%>
    |<%- if field.enum? -%>
    |public enum <%= payload_field_type_name(post_message, field) %> {
    |<%- field.type.each do |entry| -%>
    |    case <%= entry.camel_case %>
    |<%- end -%>
    |}
    |<%- elsif field.struct? %>
    |public struct <%= payload_field_type_name(post_message, field) %> {
    |    <%- field.struct_fields.each do |field| -%>
    |    public let <%= payload_property_name(field) %>: <%= payload_property_type(post_message, field) %>
    |    <%- end -%>
    |}
    |<%- end -%>
    |<%- end -%>
    |<%- end -%>
  CONTENT
  # cspell: enable

  # @example
  #
  #   event_group_type_name(PostMessageDefinition.new(:widget, :generic, :ping))
  #   # => "WidgetEvent"
  #   event_group_type_name(PostMessageDefinition.new(:widget, :connect, :memberDeleted))
  #   # => "ConnectWidgetEvent"
  #   event_group_type_name(PostMessageDefinition.new(:entity, :account, :created))
  #   # => "AccountEvent"
  #
  # @param [PostMessageDefinition] post_message
  # @return [String]
  def event_group_type_name(post_message)
    if post_message.generic?
      "WidgetEvent"
    elsif post_message.client?
      "ClientEvent"
    elsif post_message.widget?
      "#{post_message.subgroup.to_s.classify}WidgetEvent"
    else
      "#{post_message.subgroup.to_s.classify}Event"
    end
  end

  # @example
  #
  #   payload_type_name(PostMessageDefinition.new(:widget, :connect, :memberDeleted))
  #   # => "MemberDeleted"
  #
  # @param [PostMessageDefinition] post_message
  # @return [String]
  def payload_type_name(post_message)
    post_message.label.to_s.classify.normalize_keywords
  end

  # @param [PostMessageDefinition::PayloadField] field
  # @return [String]
  def payload_property_name(field)
    field.name.camel_case
  end

  # @example
  #
  #   payload_type_name(PostMessageDefinition.new(:widget, :connect, :loaded),
  #                     PostMessageDefinition::PayloadField.new(:initial_step, ["step1", "step2"]))
  #   # => "ConnectLoadedInitialStep"
  #
  # @param [PostMessageDefinition] post_message
  # @param [PostMessageDefinition::PayloadField] field
  # @return [String]
  def payload_field_type_name(post_message, field)
    "#{post_message.subgroup}_#{post_message.label}_#{field.name}".classify
  end

  # @param [PostMessageDefinition] post_message
  # @param [PostMessageDefinition::PayloadField] field
  # @param [Symbol] type (default: type, supports: code, type)
  # @return [String]
  def payload_property_type(post_message, field, format = :type)
    case [field.type, field.type_type, format]
    in ["string", :string, :type]
      "String"
    in ["boolean", :string, :type]
      "Bool"
    in ["number", :string, :type]
      "Double"
    in [_, :array | :hash, :type]
      payload_field_type_name(post_message, field)
    else
      raise StandardError, "unable to do a Swift #{format} conversion on `#{field.type}`"
    end
  end
end
