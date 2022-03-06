class Template
  include StringUtils

  attr_reader :post_message_definitions

  @@content = ""
  @@header = <<-TEXT
    |/**
    | * This file is auto-generated by widget-post-message-definitions,
    | * DO NOT EDIT.
    | *
    | * If you need to make changes to the code in this file, you can do so by
    | * modifying the definitions found in the widget-post-message-definitions
    | * project.
    | */
  TEXT

  # @param [String] header
  def self.header(header)
    @@header = header
  end

  # @param [String] content
  def self.content(content)
    @@content = content
  end

  # @param [Hash] kwargs
  # @return [String]
  def self.render(**kwargs)
    scope = Scope.create(new(**kwargs))
    "#{erb(@@header, scope)}\n\n#{erb(@@content, scope)}"
  end

  # ERB render helper method that strips a template of its margin and renders
  # the results bound to the given scope.
  #
  # @param [String] template
  # @param [Scope] scope
  # @return [String]
  def self.erb(template, scope)
    ERB.new(StringUtils.strip_margin(template), trim_mode: "-").result(scope)
  end

  # @param [String] file_path
  # @param [Hash] kwargs
  def self.save(file_path, **kwargs)
    File.open(file_path, "w") do |handle|
      contents = render(**kwargs)
      puts contents if ENV["DEBUG"] == "1"
      handle.write(contents)
    end
  end

  # @param [Array<PostMessageDefinition>] post_message_definitions
  def initialize(post_message_definitions:)
    @post_message_definitions = post_message_definitions
  end
end
