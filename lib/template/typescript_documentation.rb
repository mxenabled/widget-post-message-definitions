class Template::TypescriptDocumentation < Template::TypescriptSource
  HEADER = ""
  CONTENT = <<-CONTENT
    |<%- post_message_definitions_by_widget.each do |widget, post_messages| -%>
    |### <%= widget_name(widget) %> Post Messages
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
    |<%- end -%>
  CONTENT
end
