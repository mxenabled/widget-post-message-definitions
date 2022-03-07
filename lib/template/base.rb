class Template::Base
  attr_reader :post_message_definitions

  CONTENT = ""
  HEADER = <<-TEXT
    |/**
    | * This file is auto-generated by widget-post-message-definitions,
    | * DO NOT EDIT.
    | *
    | * If you need to make changes to the code in this file, you can do so by
    | * modifying the definitions found in the widget-post-message-definitions
    | * project.
    | */
  TEXT

  # @param [Hash] kwargs
  # @return [String]
  def self.render(**kwargs)
    ctx = new(**kwargs).binding
    "#{erb(self.const_get(:HEADER), ctx)}\n\n#{erb(self.const_get(:CONTENT), ctx)}"
  end

  # ERB render helper method that strips a template of its margin and renders
  # the results bound to the given binding.
  #
  # @param [String] template
  # @param [Binding] ctx
  # @return [String]
  def self.erb(template, ctx)
    ERB.new(template.strip_margin, trim_mode: "-").result(ctx)
  end

  # @param [String] file_path
  # @param [Hash] kwargs
  def self.save(file_path, **kwargs)
    File.open(file_path, "w") do |handle|
      contents = render(**kwargs)
      print "Writing #{contents.size} bytes to #{file_path} ..."
      handle.write(contents)
      puts " done"
    end
  end

  # @param [Array<PostMessageDefinition>] post_message_definitions
  def initialize(post_message_definitions:)
    @post_message_definitions = post_message_definitions
  end

  # rubocop:disable Lint/UselessMethodDefinition
  # @return [Binding]
  def binding
    super
  end
  # rubocop:enable Lint/UselessMethodDefinition
end
