class Template::TypescriptWebDocumentation < Template::TypescriptDocumentation
  CONTENT = <<-CONTENT
    #{ITEM_HEADER}
    |<details>
    |<summary>Click here to view a sample usage of <code><%= callback_function_name(post_message) %></code>.</summary>
    |
    |```javascript
    |const widget = widgetSdk.<%= widget_component(widget) %>({
    |  url: "<%= widget_sample_url(widget) %>",
    |
    |  <%= callback_function_name(post_message) %>: (payload) => {
    |    <%- post_message.payload.each do |field| -%>
    |    console.log(`<%= field.name.titleize %>: ${payload.<%= field.name %>}`)
    |    <%- end -%>
    |  }
    |})
    |```
    |
    |</details>
    |
    #{ITEM_FOOTER}
  CONTENT
end
