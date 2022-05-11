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
    |    <%- post_message.payload.each do |property, rhs| -%>
    |    console.log(`<%= property.titleize %>: ${payload.<%= property %>}`)
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
