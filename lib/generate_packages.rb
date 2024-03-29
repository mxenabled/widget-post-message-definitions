require_relative "./main"

post_message_definitions = PostMessageDefinition.load_file("./lib/post_message_definition.yml")

Template::SwiftSource.save("packages/swift/Sources/Generated.swift",
                           post_message_definitions: post_message_definitions)
Template::TypescriptSource.save("packages/typescript/src/generated.ts",
                                post_message_definitions: post_message_definitions)
Template::TypescriptReactNativeDocumentation.save("packages/typescript/docs/react-native-sdk-generated.md",
                                                  post_message_definitions: post_message_definitions)
Template::TypescriptWebDocumentation.save("packages/typescript/docs/web-sdk-generated.md",
                                          post_message_definitions: post_message_definitions)
