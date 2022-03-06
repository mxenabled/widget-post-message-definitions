require "erb"
require "yaml"

require_relative "./scope"
require_relative "./string_utils"
require_relative "./post_message_definition"

require_relative "./template"
require_relative "./template/typescript"

post_message_definitions = PostMessageDefinition.load_file("./lib/definitions.yml")

File.open("packages/typescript/src/generated.ts", "w") do |handle|
  contents = Typescript.render(post_message_definitions: post_message_definitions)
  puts contents
  handle.write(contents)
end
