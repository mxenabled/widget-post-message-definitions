class Template::TypescriptDocumentation < Template::TypescriptSource
  HEADER = ""
  CONTENT = <<-CONTENT
    |<%- post_message_definitions_by_widget.each do |widget, post_messages| -%>
    |<%- next unless widget == :connect -%>
    |## <%= widget_name(widget) %> Post Messages
    |
    |<%- post_messages.each do |post_message| -%>
    |### <%= normalize_keywords(post_message.label.to_s.titleize) %> (`<%= post_message %>`)
    |
    |- Widget callback prop name: `<%= callback_function_name(post_message) %>`
    |<%- unless post_message.payload.empty? -%>
    |- Payload fields:
    |    <%- post_message.payload.each do |property, rhs| -%>
    |    <%- if rhs.is_a?(Array) -%>
    |    - `<%= property %>` (`<%= payload_property_type("string") %>`)
    |        - One of:
    |            <%- rhs.each do |option| -%>
    |            - `"<%= option %>"`
    |            <%- end -%>
    |    <%- elsif rhs.is_a?(Hash) -%>
    |    - `<%= property %>` (`<%= payload_property_type("object") %>`)
    |        <%- rhs.each do |property, deep_rhs| -%>
    |        - `<%= property %>` (`<%= payload_property_type(deep_rhs) %>`)
    |        <%- end -%>
    |    <%- else -%>
    |    - `<%= property %>` (`<%= payload_property_type(rhs) %>`)
    |    <%- end -%>
    |    <%- end -%>
    |<%- end -%>
    |
    |<%- end -%>
    |
    |### Example
    |
    |```jsx
    |import { <%= widget_component(widget) %> } from "@mxenabled/react-native-widget-sdk"
    |
    |<<%= widget_component(widget) %>
    |  url="<%= widget_sample_url(widget) %>"
    |
    |<%- post_messages.each do |post_message| -%>
    |  <%= callback_function_name(post_message) %>={(payload) => console.log(payload)}
    |<%- end -%>
    |/>
    |```
    |
    |<%- end -%>
  CONTENT

  # @example
  #
  #   widget_component(:connect)
  #   # => "ConnectWidget"
  #
  # @param [String] group
  # @return [String]
  def widget_component(group)
    "#{normalize_keywords(group.to_s.classify)}Widget"
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
