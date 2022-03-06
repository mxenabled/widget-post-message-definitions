class Typescript < Template
  content <<-EOS
    |import { UnknownPostMessageError, Metadata, assertMessageProp } from "./lib"
    |
    |export enum Type {
    |  <%- post_message_definitions.each do |post_message| -%>
    |  <%= enum_key(post_message) %> = "<%= enum_value(post_message) %>",
    |  <%- end -%>
    |}
    |
    |export const typeLookup: Record<string, Type> = {
    |  <%- post_message_definitions.each do |post_message| -%>
    |  [<%= qualified_enum_key(post_message) %>]: <%= qualified_enum_key(post_message) %>,
    |  <%- if needs_uri_friendly_lookup?(post_message) -%>
    |  "<%= uri_friendly_lookup(post_message) %>": <%= qualified_enum_key(post_message) %>,
    |  <%- end -%>
    |  <%- end -%>
    |}
    |
    |<% post_message_definitions.each do |post_message| %>
    |export type <%= payload_type(post_message) %> = {
    |  type: <%= qualified_enum_key(post_message) %>,
    |  <%- post_message.properties.each do |property, rhs| -%>
    |  <%= property %>: <%= payload_property_type(rhs) %>,
    |  <%- end -%>
    |}
    |<%- end -%>
    |
    |<% post_message_definitions_by_group.each do |group, post_message_definitions| %>
    |export type <%= payload_group_type(group) %> =
    |  <%- post_message_definitions.each do |post_message| -%>
    |  | <%= payload_type(post_message) %>
    |  <%- end -%>
    |<%- end -%>
    |
    |export type <%= payload_group_type(nil) %> =
    |  <%- post_message_definitions_by_group.each do |(group)| -%>
    |  | <%= payload_group_type(group) %>
    |  <%- end -%>
    |
    |/**
    | * Given a post message type (eg, "mx/load", "mx/connect/memberConnected") and
    | * the payload for that message, this function parses the payload object and
    | * returns a validated and typed object.
    | *
    | * @param {Type} type
    | * @param {Metadata, Object} metadata
    | * @throws {UnknownPostMessageError}
    | * @throws {PostMessageFieldDecodeError}
    | * @return {Payload}
    | */
    |export function buildPayload(type: Type, metadata: Metadata): Payload {
    |  switch (type) {
    |    <%- post_message_definitions.each do |post_message| -%>
    |    case <%= qualified_enum_key(post_message) %>:
    |      <%- post_message.properties.each do |property, rhs| -%>
    |      assertMessageProp(metadata, "<%= post_message %>", "<%= property %>", <%= payload_property_type(rhs, :code) %>)
    |      <%- end -%>
    |
    |      return {
    |        type,
    |        <%- post_message.properties.each do |property, rhs| -%>
    |        <%= property %>: metadata.<%= property %> as <%= payload_property_type(rhs) %>,
    |        <%- end -%>
    |      }
    |
    |    <%- end -%>
    |    default:
    |      throw new UnknownPostMessageError(type)
    |  }
    |}
    |
    |export type EntityCallbackProps = {
    |<%- post_message_definitions_of_group(:entity).each do |post_messages| -%>
    |  <%= callback_name(post_messages) %>?: (payload: <%= payload_type(post_messages) %>) => void
    |<%- end -%>
    |}
    |
    |export type GenericCallbackProps = {
    |<%- post_message_definitions_of_subgroup(:generic).each do |post_messages| -%>
    |  <%= callback_name(post_messages) %>?: (payload: <%= payload_type(post_messages) %>) => void
    |<%- end -%>
    |}
  EOS

  # Generates the enum type key for a give post message.
  #
  # @example
  #
  #   enum_key("mx/ping")
  #   # => "Ping"
  #
  #   enum_key("mx/connect/memberDeleted")
  #   # => "ConnectMemberDeleted"
  #
  #   enum_key("mx/pulse/overdraftWarning/cta/transferFunds")
  #   # => "PulseOverdraftwarningCtaTransferfunds"
  #
  #
  # @param [PostMessageDefinition] post_message_definition
  # @return [String]
  def enum_key(post_message)
    label = post_message.label.to_s.gsub("/", "_")
    post_message.grouped? ?
      classify("#{post_message.subgroup}_#{label}") :
      classify(label)
  end

  # @see enum_key
  # @param [PostMessageDefinition] post_message_definition
  # @return [String]
  def qualified_enum_key(post_message)
    "Type.#{enum_key(post_message)}"
  end

  # @param [PostMessageDefinition] post_message_definition
  # @return [String]
  def enum_value(post_message)
    post_message.to_s
  end

  # From https://datatracker.ietf.org/doc/html/rfc3986#section-3.2.2:
  #
  # > Although host is case-insensitive, producers and normalizers should use
  # > lowercase for registered names and hexadecimal addresses for the sake of
  # > uniformity, while only using uppercase letters for percent-encodings.
  #
  # Because of this, URL parsers will (or should at least. Node's url package
  # does, for example) convert the host to lowercase which causes problems when
  # we do a type lookup on a post message. We introduce a lowercased entry in
  # our type lookup so that when doing a lookup with a lowercased host we get a
  # match.
  #
  # The "mx/focusTrap" event if the only post message that has this issue,
  # since in this case "focusTrap" ends up being the host and contains an
  # uppercase letter. Other messages with uppercase letters only have them in
  # the path (eg, "mx/connect/memberDeleted"), so those are fine.
  #
  # @param [PostMessageDefinition] post_message_definition
  # @return [Boolean]
  def needs_uri_friendly_lookup?(post_message)
    uri_friendly_lookup(post_message) != post_message.to_s
  end

  # @param [PostMessageDefinition] post_message_definition
  # @return [String]
  def uri_friendly_lookup(post_message)
    post_message.to_s.downcase
  end

  # @param [PostMessageDefinition] post_message_definition
  # @return [String]
  def payload_type(post_message)
    "#{enum_key(post_message)}Payload"
  end

  # @param [String] group
  # @return [String]
  def payload_group_type(group)
    "#{classify(group)}Payload"
  end

  # @param [PostMessageDefinition] post_message
  # @return [String]
  def callback_name(post_message)
    "on#{enum_key(post_message)}"
  end

  # @example
  #
  #   payload_property_type("string")
  #   # => "string"
  #
  #   payload_property_type("number", :type)
  #   # => "number"
  #
  #   payload_property_type(["one", "two", "three"], :type)
  #   # => '"one" | "two" | "three"'
  #
  #   payload_property_type({ name: string, age: number }, :type)
  #   # => "{ name: string, age: number }"
  #
  #   payload_property_type(["one", "two", "three"], :code)
  #   # => '["one", "two", "three"]'
  #
  #   payload_property_type({ name: string, age: number }, :code)
  #   # => '{ name: "string", age: "number" }'
  #
  # @param [String, Hash, Array<String>] raw
  # @param [Symbol] type (default: type, supports: code, type)
  # @return [String]
  def payload_property_type(raw, format = :type)
    case [raw.class.to_s.downcase.to_sym, format]
    in [:string, :type]
      raw
    in [:string, :code]
      surround(raw, "\"")
    in [:array, :type]
      raw.map { |s| surround(s, "\"") }.join(" | ")
    in [:array, :code]
      values = raw.map { |s| surround(s, "\"") }.join(", ")
      surround(values, "[", "]")
    in [:hash, :type | :code]
      props = raw.map { |key, value| "#{key}: #{payload_property_type(value, format)}" }.join(", ")
      surround(props, "{ ", " }")
    else
      raise StandardError, "unable to convert `#{raw}` into TypeScript #{format}"
    end
  end

  # @return [Hash]
  def post_message_definitions_by_group
    post_message_definitions.group_by(&:group)
  end

  # @return [Symbol] group
  # @return [Array<PostMessageDefinition>]
  def post_message_definitions_of_group(group)
    post_message_definitions.filter do |post_message|
      post_message.group == group
    end
  end

  # @return [Symbol] subgroup
  # @return [Array<PostMessageDefinition>]
  def post_message_definitions_of_subgroup(subgroup)
    post_message_definitions.filter do |post_message|
      post_message.subgroup == subgroup
    end
  end
end
