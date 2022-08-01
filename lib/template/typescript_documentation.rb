class Template::TypescriptDocumentation < Template::TypescriptSource
  using StringRefinement

  HEADER = <<-HEADER
    |<!--
    |This file is auto-generated by widget-post-message-definitions,
    |DO NOT EDIT.
    |
    |If you need to make changes to the code in this file, you can do so by
    |modifying the definitions found in the widget-post-message-definitions[1]
    |project.
    |
    |[1] https://github.com/mxenabled/widget-post-message-definitions
    |-->
  HEADER

  ITEM_HEADER = <<-ITEM_HEADER
    |<%- post_message_definitions_by_widget.each do |widget, post_messages| -%>
    |<%- next unless widget == :connect -%>
    |## <%= widget_name(widget) %> Post Messages
    |
    |<%- post_messages.each do |post_message| -%>
    |<%- next unless post_message.documented? -%>
    |---
    |### <%= post_message.label.to_s.titleize.normalize_keywords %> (`<%= post_message %>`)
    |
    |<%- if post_message.properties["warning"] -%>
    |**Warning**: <%= post_message.properties["warning"] %>
    |<%- end -%>
    |- Widget callback prop name: `<%= callback_function_name(post_message) %>`
    |<%- unless post_message.payload.empty? -%>
    |- Payload fields:
    |    <%- post_message.payload.each do |field| -%>
    |    <%- if field.type.is_a?(Array) -%>
    |    - <%= payload_field_heading(field) %> (`<%= payload_property_type("string") %>`)
    |        - One of:
    |            <%- field.type.each do |option| -%>
    |            - `"<%= option %>"`
    |            <%- end -%>
    |    <%- elsif field.type.is_a?(Hash) -%>
    |    - <%= payload_field_heading(field) %> (`<%= payload_property_type("object") %>`)
    |        <%- field.type.each do |property, deep_rhs| -%>
    |        - `<%= property %>` (`<%= payload_property_type(deep_rhs) %>`)
    |        <%- end -%>
    |    <%- else -%>
    |    - <%= payload_field_heading(field) %> (`<%= payload_property_type(field.type) %>`)
    |    <%- end -%>
    |    <%- end -%>
    |<%- end -%>
  ITEM_HEADER

  ITEM_FOOTER = <<-ITEM_FOOTER
    |<%- end -%>
    |<%- end -%>
  ITEM_FOOTER

  # @param [PostMessageDefinition::PayloadField] field
  # @return [String]
  def payload_field_heading(field)
    if field.optional?
      "`#{field.name}` (optional)"
    else
      "`#{field.name}`"
    end
  end

  # @example
  #
  #   widget_component(:connect)
  #   # => "ConnectWidget"
  #
  # @param [String] group
  # @return [String]
  def widget_component(group)
    "#{group.to_s.classify.normalize_keywords}Widget"
  end

  # @example
  #
  #   widget_sample_url(:connect)
  #   # => "https://widgets.moneydesktop.com/md/connect/..."
  #
  # @param [String] group
  # @return [String]
  def widget_sample_url(group)
    "https://widgets.moneydesktop.com/md/#{group}/..."
  end
end
