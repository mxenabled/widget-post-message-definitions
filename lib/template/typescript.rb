class Typescript < Template
  content <<-EOS
    |export enum Type {
    |  <%- post_message_definitions.each do |post_message| -%>
    |  <%= enum_key(post_message) %> = "<%= enum_value(post_message) %>",
    |  <%- end -%>
    |}
    |
    |export const typeLookup: Record<string, Type> = {
    |  <%- post_message_definitions.each do |post_message| -%>
    |  [<%= qualified_enum_key(post_message) %>] = <%= qualified_enum_key(post_message) %>,
    |  "<%= uri_friendly_lookup(post_message) %>" = <%= qualified_enum_key(post_message) %>,
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

  # @example
  #
  #   payload_property_type("string")
  #   # => "string"
  #
  #   payload_property_type("number")
  #   # => "number"
  #
  #   payload_property_type(["one", "two", "three"])
  #   # => '"one" | "two" | "three"'
  #
  #   payload_property_type({ name: string, age: number })
  #   # => "{ name: string, age: number }"
  #
  # @param [String, Hash, Array<String>] raw
  # @return [String]
  def payload_property_type(raw)
    case raw.class.to_s.downcase.to_sym
    when :string
      raw
    when :array
      raw.map { |s| surround(s, "\"") }.join(" | ")
    when :hash
      props = raw.map do |key, value|
        "#{key}: #{payload_property_type(value)}"
      end.join(", ")

      surround(props, "{ ", " }")
    else
      raise StandardError, "unable to convert `#{raw}` into a TypeScript type"
    end
  end

  # @return [Hash]
  def post_message_definitions_by_group
    post_message_definitions.group_by(&:group)
  end
end
