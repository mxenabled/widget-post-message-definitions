class Template::TypescriptSource < Template::Base
  using StringRefinement

  # cspell: disable
  CONTENT = <<-CONTENT
    |import {
    |  <%= callback_props_group_type_name(:base) %>,
    |  MessageEventData,
    |  Metadata,
    |  PostMessageFieldDecodeError,
    |  PostMessageUnknownTypeError,
    |  assertMessageProp,
    |} from "./lib"
    |
    |export enum Type {
    |  <%- post_message_definitions.each do |post_message| -%>
    |  <%= enum_key(post_message) %> = "<%= enum_value(post_message) %>",
    |  <%- end -%>
    |}
    |
    |const typeLookup: Record<string, Type> = {
    |  <%- post_message_definitions.each do |post_message| -%>
    |  [<%= qualified_enum_key(post_message) %>]: <%= qualified_enum_key(post_message) %>,
    |  <%- if needs_uri_friendly_lookup?(post_message) -%>
    |  "<%= uri_friendly_lookup(post_message) %>": <%= qualified_enum_key(post_message) %>, // cspell:disable-line
    |  <%- end -%>
    |  <%- end -%>
    |}
    |
    |<% post_message_definitions.each do |post_message| %>
    |export type <%= payload_type_name(post_message) %> = {
    |  type: <%= qualified_enum_key(post_message) %>,
    |  <%- post_message.payload.each do |field| -%>
    |  <%- if field.optional? -%>
    |  <%= field.name %>?: <%= payload_property_type(field.type) %>,
    |  <%- else -%>
    |  <%= field.name %>: <%= payload_property_type(field.type) %>,
    |  <%- end -%>
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
    | * @throws {PostMessageUnknownTypeError}
    | * @throws {PostMessageFieldDecodeError}
    | */
    |function buildPayload(type: Type, metadata: Metadata): Payload {
    |  switch (type) {
    |    <%- post_message_definitions.each do |post_message| -%>
    |    case <%= qualified_enum_key(post_message) %>:
    |      <%- post_message.payload.each do |field| -%>
    |      <%- if field.optional? -%>
    |      assertMessageProp(metadata, "<%= post_message %>", "<%= field.name %>", <%= payload_property_type(field.type, :code) %>, {
    |        optional: true,
    |      })
    |      <%- else -%>
    |      assertMessageProp(metadata, "<%= post_message %>", "<%= field.name %>", <%= payload_property_type(field.type, :code) %>)
    |      <%- end -%>
    |      <%- end -%>
    |
    |      return {
    |        type,
    |        <%- post_message.payload.each do |field| -%>
    |        <%- if field.optional? -%>
    |        <%= field.name %>: metadata.<%= field.name %> as <%= payload_property_type(field.type) %> | undefined,
    |        <%- else -%>
    |        <%= field.name %>: metadata.<%= field.name %> as <%= payload_property_type(field.type) %>,
    |        <%- end -%>
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
    | */
    |function buildPayloadFromUrl(url: string): Payload {
    |  const { parse } = require("url")
    |  const urlObj = parse(url, true)
    |
    |  const namespace = urlObj.host || ""
    |  const action = (urlObj.pathname || "").substring(1)
    |  const rawType = action ? `mx/${namespace}/${action}` : `mx/${namespace}`
    |  let type: Type
    |  if (rawType in typeLookup) {
    |    type = typeLookup[rawType]
    |  } else {
    |    throw new PostMessageUnknownTypeError(rawType)
    |  }
    |
    |  const rawMetadataParam = urlObj.query?.["metadata"] || "{}"
    |  const rawMetadataString = Array.isArray(rawMetadataParam) ?
    |    rawMetadataParam.join("") :
    |    rawMetadataParam
    |  const metadata = JSON.parse(rawMetadataString)
    |  const payload = buildPayload(type, metadata)
    |
    |  return payload
    |}
    |
    |/**
    | * @see {buildPayload}
    | */
    |function buildPayloadFromPostMessageEventData(data: MessageEventData): Payload {
    |  const rawType = data.type || "type not provided"
    |  let type: Type
    |  if (rawType && rawType in typeLookup) {
    |    type = typeLookup[rawType]
    |  } else {
    |    throw new PostMessageUnknownTypeError(rawType)
    |  }
    |
    |  const metadata = data.metadata || {}
    |  const payload = buildPayload(type, metadata)
    |
    |  return payload
    |}
    |
    |export type <%= callback_props_group_type_name(:widget) %><T> =
    |  & <%= callback_props_group_type_name(:base) %><T>
    |  & <%= callback_props_group_type_name(:entity) %>
    |  & <%= callback_props_group_type_name(:generic) %>
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
    |export type <%= callback_props_group_type_name(subgroup) %><T> = <%= callback_props_group_type_name(:widget) %><T> & {
    |  <%- post_messages.each do |post_messages| -%>
    |  <%= callback_function_name(post_messages) %>?: (payload: <%= payload_type_name(post_messages) %>) => void
    |  <%- end -%>
    |}
    |<%- end -%>
    |
    |/**
    | * Called if we encounter an error while parsing or dispatching a post message
    | * event. Internal errors are dispatched to the appropriate error callback, and
    | * everything else is thrown so it can be handled in the host application since
    | * it's likely an application/user-level error.
    | */
    |function dispatchError<T>(message: T, error: unknown, callbacks: <%= callback_props_group_type_name(:base) %><T>) {
    |  if (error instanceof PostMessageFieldDecodeError) {
    |    callbacks.onInvalidMessageError?.(message, error)
    |  } else if (error instanceof PostMessageUnknownTypeError) {
    |    callbacks.onInvalidMessageError?.(message, error)
    |  } else {
    |    throw error
    |  }
    |}
    |
    |/**
    | * We dispatch all messages to the onMessage callback.
    | */
    |function dispatchOnMessage<T>(message: T, callbacks: <%= callback_props_group_type_name(:base) %><T>) {
    |  callbacks.onMessage?.(message)
    |}
    |
    |/**
    | * Dispatch a post message event that we got from a url change event for any
    | * widget. Does not handle widget specific post messages. See other dispatch
    | * methods for widget specific dispatching.
    | */
    |export function <%= dispatch_location_change_function_name(:widget) %>(url: string, callbacks: <%= callback_props_group_type_name(:widget) %><string>) {
    |  try {
    |    dispatchOnMessage(url, callbacks)
    |    const payload = buildPayloadFromUrl(url)
    |    <%= dispatch_internal_message_function_name(:widget) %>(payload, callbacks)
    |  } catch (error) {
    |    dispatchError(url, error, callbacks)
    |  }
    |}
    |
    |/**
    | * Dispatch a post message event that we got from a message event for any
    | * widget. Does not handle widget specific post messages. See other dispatch
    | * methods for widget specific dispatching.
    | */
    |export function <%= dispatch_post_message_function_name(:widget) %>(event: MessageEvent<MessageEventData>, callbacks: <%= callback_props_group_type_name(:widget) %><MessageEvent<MessageEventData>>) {
    |  try {
    |    dispatchOnMessage(event, callbacks)
    |    const payload = buildPayloadFromPostMessageEventData(event.data)
    |    <%= dispatch_internal_message_function_name(:widget) %>(payload, callbacks)
    |  } catch (error) {
    |    dispatchError(event, error, callbacks)
    |  }
    |}
    |
    |/**
    | * Dispatch a validated internal message for any widget.
    | */
    |function <%= dispatch_internal_message_function_name(:widget) %><T>(payload: Payload, callbacks: <%= callback_props_group_type_name(:widget) %><T>) {
    |  switch (payload.type) {
    |    <%- (generic_post_message_definitions + entity_post_message_definitions).each do |post_message| -%>
    |    case <%= qualified_enum_key(post_message) %>:
    |      callbacks.<%= callback_function_name(post_message) %>?.(payload)
    |      break
    |
    |    <%- end -%>
    |    default:
    |      throw new PostMessageUnknownTypeError(payload.type)
    |  }
    |}
    |
    |<% post_message_definitions_by_widget.each do |subgroup, post_messages| %>
    |/**
    | * Dispatch a post message event that we got from a url change event for the
    | * <%= widget_name(subgroup) %>.
    | */
    |export function <%= dispatch_location_change_function_name(subgroup) %>(url: string, callbacks: <%= callback_props_group_type_name(subgroup) %><string>) {
    |  try {
    |    dispatchOnMessage(url, callbacks)
    |    const payload = buildPayloadFromUrl(url)
    |    <%= dispatch_internal_message_function_name(subgroup) %>(payload, callbacks)
    |  } catch (error) {
    |    dispatchError(url, error, callbacks)
    |  }
    |}
    |
    |/**
    | * Dispatch a post message event that we got from a window/document message for the
    | * <%= widget_name(subgroup) %>.
    | */
    |export function <%= dispatch_post_message_function_name(subgroup) %>(event: MessageEvent<MessageEventData>, callbacks: <%= callback_props_group_type_name(subgroup) %><MessageEvent<MessageEventData>>) {
    |  try {
    |    dispatchOnMessage(event, callbacks)
    |    const payload = buildPayloadFromPostMessageEventData(event.data)
    |    <%= dispatch_internal_message_function_name(subgroup) %>(payload, callbacks)
    |  } catch (error) {
    |    dispatchError(event, error, callbacks)
    |  }
    |}
    |
    |/**
    | * Dispatch a validated internal message for the <%= widget_name(subgroup) %>.
    | */
    |function <%= dispatch_internal_message_function_name(subgroup) %><T>(payload: Payload, callbacks: <%= callback_props_group_type_name(subgroup) %><T>) {
    |  switch (payload.type) {
    |    <%- (generic_post_message_definitions + entity_post_message_definitions).each do |post_message| -%>
    |    case <%= qualified_enum_key(post_message) %>:
    |      callbacks.<%= callback_function_name(post_message) %>?.(payload)
    |      break
    |
    |    <%- end -%>
    |    <%- post_messages.each do |post_message| -%>
    |    case <%= qualified_enum_key(post_message) %>:
    |      callbacks.<%= callback_function_name(post_message) %>?.(payload)
    |      break
    |
    |    <%- end -%>
    |    default:
    |      throw new PostMessageUnknownTypeError(payload.type)
    |  }
    |}
    |<%- end -%>
  CONTENT
  # cspell: enable

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
  #   # => "PulseOverdraftWarningCtaTransferFunds"
  #
  #
  # @param [PostMessageDefinition] post_message_definition
  # @return [String]
  def enum_key(post_message)
    if post_message.grouped?
      "#{post_message.subgroup}_#{post_message.label}".classify.normalize_keywords
    else
      post_message.label.to_s.classify.normalize_keywords
    end
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
    "#{group.to_s.classify}Payload".normalize_keywords
  end

  # @example
  #
  #   callback_props_group_type_name(:widget)
  #   # => "WidgetPostMessageCallbackProps"
  #
  # @param [String] group
  # @return [String]
  def callback_props_group_type_name(group)
    "#{group.to_s.classify}PostMessageCallbackProps".normalize_keywords
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
      "on#{post_message.label.to_s.classify.normalize_keywords}"
    end
  end

  # @example
  #
  #   dispatch_location_change_function_name(:generic)
  #   # => "dispatchWidgetLocationChangeEvent"
  #
  # @param [String] group
  # @return [String]
  def dispatch_location_change_function_name(group)
    "dispatch#{group.to_s.classify.normalize_keywords}LocationChangeEvent"
  end

  # @example
  #
  #   dispatch_post_message_function_name(:generic)
  #   # => "dispatchWidgetPostMessageEvent"
  #
  # @param [String] group
  # @return [String]
  def dispatch_post_message_function_name(group)
    "dispatch#{group.to_s.classify.normalize_keywords}PostMessageEvent"
  end

  # @example
  #
  #   dispatch_internal_message_function_name(:generic)
  #   # => "dispatchWidgetInternalMessage"
  #
  # @param [String] group
  # @return [String]
  def dispatch_internal_message_function_name(group)
    "dispatch#{group.to_s.classify.normalize_keywords}InternalMessage"
  end

  # @example
  #
  #   widget_name(:connect)
  #   # => "Connect Widget"
  #
  # @param [String] group
  # @return [String]
  def widget_name(group)
    "#{group.to_s.classify.normalize_keywords} Widget"
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
end
