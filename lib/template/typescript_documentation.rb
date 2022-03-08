class Template::TypescriptDocumentation < Template::TypescriptSource
  HEADER = ""
  CONTENT = <<-CONTENT
    |<%- post_message_definitions_by_widget.each do |widget, post_messages| -%>
    |## <%= widget_name(widget) %> Post Messages
    |
    |<%- post_messages.each do |post_message| -%>
    |#### <%= normalize_keywords(post_message.label.to_s.titleize) %>
    |
    |- Post message event type: `<%= post_message %>`
    |- Widget callback prop name: `<%= callback_function_name(post_message) %>`
    |<%- unless post_message.properties.empty? -%>
    |- Payload:
    |    <%- post_message.properties.each do |property, rhs| -%>
    |    - `<%= property %>` (`<%= payload_property_type(rhs) %>`)
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
