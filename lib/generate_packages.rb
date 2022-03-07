require_relative "./main"

post_message_definitions = PostMessageDefinition.load_file("./lib/post_message_definition.yml")

Template::TypescriptSource.save("packages/typescript/src/generated.ts",
                                post_message_definitions: post_message_definitions)
