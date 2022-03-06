require "erb"
require "yaml"

require_relative "./string_utils"
require_relative "./post_message_definition"

require_relative "./template/base"
require_relative "./template/typescript"

post_message_definitions = PostMessageDefinition.load_file("./lib/definitions.yml")

Template::Typescript.save("packages/typescript/src/generated.ts", post_message_definitions: post_message_definitions)
