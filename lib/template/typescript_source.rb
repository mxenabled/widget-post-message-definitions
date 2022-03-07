class Template::TypescriptSource < Template::Base
  CONTENT = <<-EOS
    |import { parse as parseUrl } from "url"
    |
    |import {
    |  BaseCallbackProps,
    |  Metadata,
    |  PostMessageCallbackDispatchError,
    |  PostMessageFieldDecodeError,
    |  PostMessageUnknownTypeError,
    |  assertMessageProp,
    |  safeCall,
    |} from "./lib"
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
    |export type <%= payload_type_name(post_message) %> = {
    |  type: <%= qualified_enum_key(post_message) %>,
    |  <%- post_message.properties.each do |property, rhs| -%>
    |  <%= property %>: <%= payload_property_type(rhs) %>,
    |  <%- end -%>
    |}
    |<%- end -%>
    |
    |<% post_message_definitions_by_group.each do |group, post_message_definitions| %>
    |export type <%= payload_group_type_name(group) %> =
    |  <%- post_message_definitions.each do |post_message| -%>
    |  | <%= payload_type_name(post_message) %>
    |  <%- end -%>
    |<%- end -%>
    |
    |export type <%= payload_group_type_name(nil) %> =
    |  <%- post_message_definitions_by_group.each do |(group)| -%>
    |  | <%= payload_group_type_name(group) %>
    |  <%- end -%>
    |
    |/**
    | * Given a post message type (eg, "mx/load", "mx/connect/memberConnected") and
    | * the payload for that message, this function parses the payload object and
    | * returns a validated and typed object.
    | *
    | * @param {Type} type
    | * @param {Metadata, Object} metadata
    | * @return {Payload}
    | * @throws {PostMessageUnknownTypeError}
    | * @throws {PostMessageFieldDecodeError}
    | */
    |function buildPayload(type: Type, metadata: Metadata): Payload {
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
    |      throw new PostMessageUnknownTypeError(type)
    |  }
    |}
    |
    |/**
    | * @see {buildPayload}
    | * @param {String} url
    | * @return {Payload}
    | * @throws {PostMessageUnknownTypeError}
    | * @throws {PostMessageFieldDecodeError}
    | */
    |function buildPayloadFromUrl(urlString: string): Payload {
    |  const url = parseUrl(urlString, true)
    |
    |  const namespace = url.host || ""
    |  const action = (url.pathname || "").substring(1)
    |  const rawType = action ? `mx/${namespace}/${action}` : `mx/${namespace}`
    |  let type: Type
    |  if (rawType in typeLookup) {
    |    type = typeLookup[rawType]
    |  } else {
    |    throw new PostMessageUnknownTypeError(rawType)
    |  }
    |
    |  const rawMetadataParam = url.query?.["metadata"] || "{}"
    |  const rawMetadataString = Array.isArray(rawMetadataParam) ?
    |    rawMetadataParam.join("") :
    |    rawMetadataParam
    |  const metadata = JSON.parse(rawMetadataString)
    |  const payload = buildPayload(type, metadata)
    |
    |  return payload
    |}
    |
    |export type <%= callback_props_group_type_name(:widget) %> =
    |  & BaseCallbackProps
    |  & EntityCallbackProps
    |  & GenericCallbackProps
    |
    |export type <%= callback_props_group_type_name(:entity) %> = {
    |<%- entity_post_message_definitions.each do |post_message| -%>
    |  <%= callback_function_name(post_message) %>?: (payload: <%= payload_type_name(post_message) %>) => void
    |<%- end -%>
    |}
    |
    |export type <%= callback_props_group_type_name(:generic) %> = {
    |<%- generic_post_message_definitions.each do |post_message| -%>
    |  <%= callback_function_name(post_message) %>?: (payload: <%= payload_type_name(post_message) %>) => void
    |<%- end -%>
    |}
    |
    |<% post_message_definitions_by_widget.each do |subgroup, post_messages| %>
    |export type <%= callback_props_group_type_name(subgroup) %> = <%= callback_props_group_type_name(:widget) %> & {
    |  <%- post_messages.each do |post_messages| -%>
    |  <%= callback_function_name(post_messages) %>?: (payload: <%= payload_type_name(post_messages) %>) => void
    |  <%- end -%>
    |}
    |<%- end -%>
    |
    |/**
    | * @param {String} url
    | * @param {unknown} error
    | * @param {<%= callback_props_group_type_name(:widget) %>} callbacks
    | * @throws {Error}
    | * @throws {unknown}
    | */
    |function dispatchError(url: string, error: unknown, callbacks: <%= callback_props_group_type_name(:widget) %>) {
    |  if (error instanceof PostMessageFieldDecodeError) {
    |    safeCall([url, error], callbacks.onMessageUnknownError)
    |  } else if (error instanceof PostMessageCallbackDispatchError) {
    |    safeCall([url, error], callbacks.onMessageDispatchError)
    |  } else {
    |    throw error
    |  }
    |}
    |
    |/**
    | * Dispatch a post message from any widget. Does not handle widget
    | * specific post messages. See other dispatch methods for widget
    | * specific dispatching.
    | *
    | * @param {String} url
    | * @param {<%= callback_props_group_type_name(:widget) %>} callbacks
    | * @throws {Error}
    | * @throws {unknown}
    | */
    |export function <%= dispatch_function_name(:widget) %>(url: string, callbacks: <%= callback_props_group_type_name(:widget) %>) {
    |  safeCall([url], callbacks.onMessage)
    |
    |  try {
    |    const payload = buildPayloadFromUrl(url)
    |    switch (payload.type) {
    |      <%- (generic_post_message_definitions + entity_post_message_definitions).each do |post_message| -%>
    |      case <%= qualified_enum_key(post_message) %>:
    |        safeCall([payload], callbacks.<%= callback_function_name(post_message) %>)
    |        break
    |
    |      <%- end -%>
    |      default:
    |        throw new PostMessageUnknownTypeError(payload.type)
    |    }
    |  } catch (error) {
    |    dispatchError(url, error, callbacks)
    |  }
    |}
    |
    |<% post_message_definitions_by_widget.each do |subgroup, post_messages| %>
    |/**
    | * Dispatch a post message from the <%= widget_name(subgroup) %>.
    | *
    | * @param {String} url
    | * @param {<%= callback_props_group_type_name(subgroup) %>} callbacks
    | * @throws {Error}
    | * @throws {unknown}
    | */
    |export function <%= dispatch_function_name(subgroup) %>(url: string, callbacks: <%= callback_props_group_type_name(subgroup) %>) {
    |  safeCall([url], callbacks.onMessage)
    |
    |  try {
    |    const payload = buildPayloadFromUrl(url)
    |    switch (payload.type) {
    |      <%- (generic_post_message_definitions + entity_post_message_definitions).each do |post_message| -%>
    |      case <%= qualified_enum_key(post_message) %>:
    |        safeCall([payload], callbacks.<%= callback_function_name(post_message) %>)
    |        break
    |
    |      <%- end -%>
    |      <%- post_messages.each do |post_message| -%>
    |      case <%= qualified_enum_key(post_message) %>:
    |        safeCall([payload], callbacks.<%= callback_function_name(post_message) %>)
    |        break
    |
    |      <%- end -%>
    |      default:
    |        throw new PostMessageUnknownTypeError(payload.type)
    |    }
    |  } catch (error) {
    |    dispatchError(url, error, callbacks)
    |  }
    |}
    |<%- end -%>
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
    post_message.grouped? ?
      normalized_casing("#{post_message.subgroup}_#{post_message.label}") :
      normalized_casing(post_message.label)
  end

  # @see enum_key
  # @param [PostMessageDefinition] post_message_definition
  # @return [String]
  def qualified_enum_key(post_message)
    "Type.#{enum_key(post_message)}"
  end

  # @example
  #
  #   enum_value(PostMessageDefinition.new(:widget, :connect, :memberDeleted))
  #   # => "mx/connect/memberDeleted"
  #
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

  # @example
  #
  #   uri_friendly_lookup(PostMessageDefinition.new(:widget, :generic, :focusTrap))
  #   # => "mx/focustrap"
  #
  # @param [PostMessageDefinition] post_message_definition
  # @return [String]
  def uri_friendly_lookup(post_message)
    post_message.to_s.downcase
  end

  # @example
  #
  #   payload_type_name(PostMessageDefinition.new(:widget, :connect, :memberDeleted))
  #   # => "ConnectMemberDeletedPayload"
  #
  # @param [PostMessageDefinition] post_message_definition
  # @return [String]
  def payload_type_name(post_message)
    "#{enum_key(post_message)}Payload"
  end

  # @example
  #
  #   payload_group_type_name(:widget)
  #   # => "WidgetPayload"
  #
  # @param [String] group
  # @return [String]
  def payload_group_type_name(group)
    normalized_casing("#{group}Payload")
  end

  # @example
  #
  #   callback_props_group_type_name(:widget)
  #   # => "WidgetCallbackProps"
  #
  # @param [String] group
  # @return [String]
  def callback_props_group_type_name(group)
    normalized_casing("#{group}CallbackProps")
  end

  # @example
  #
  #   callback_function_name(PostMessageDefinition.new(:widget, :connect, :memberDeleted))
  #   # => "onMemberDeleted"
  #
  #   callback_function_name(PostMessageDefinition.new(:widget, :generic, :load))
  #   # => "onLoad"
  #
  #   callback_function_name(PostMessageDefinition.new(:entity, :account, :created))
  #   # => "onAccountCreated"
  #
  # @param [PostMessageDefinition] post_message
  # @return [String]
  def callback_function_name(post_message)
    if post_message.entity?
      "on#{enum_key(post_message)}"
    else
      "on#{normalized_casing(post_message.label)}"
    end
  end

  # @example
  #
  #   dispatch_function_name(:generic)
  #   # => "dispatchWidgetPostMessage"
  #
  # @param [String] group
  # @return [String]
  def dispatch_function_name(group)
    "dispatch#{normalized_casing(group)}PostMessage"
  end

  # @example
  #
  #   widget_name(:connect)
  #   # => "Connect Widget"
  #
  # @param [String] group
  # @return [String]
  def widget_name(group)
    "#{normalized_casing(group)} Widget"
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
      raw.surround("\"")
    in [:array, :type]
      raw.map { |s| s.surround("\"") }.join(" | ")
    in [:array, :code]
      values = raw.map { |s| s.surround("\"") }.join(", ")
      values.surround("[", "]")
    in [:hash, :type | :code]
      props = raw.map { |key, value| "#{key}: #{payload_property_type(value, format)}" }.join(", ")
      props.surround("{ ", " }")
    else
      raise StandardError, "unable to convert `#{raw}` into TypeScript #{format}"
    end
  end

  # @param [String] string
  # @return [String]
  def normalized_casing(string)
    string.to_s.classify.gsub("Oauth", "OAuth")
  end

  # @return [Hash]
  def entity_post_message_definitions
    post_message_definitions_of_group(:entity)
  end

  # @return [Hash]
  def generic_post_message_definitions
    post_message_definitions_of_subgroup(:generic)
  end

  # @return [Hash]
  def post_message_definitions_by_widget
    post_message_definitions_of_group(:widget).filter do |post_message|
      not post_message.generic?
    end.group_by(&:subgroup)
  end

  # @return [Hash]
  def post_message_definitions_by_group
    post_message_definitions.group_by(&:group)
  end

  # @return [Hash]
  def post_message_definitions_by_subgroup
    post_message_definitions.group_by(&:subgroup)
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
