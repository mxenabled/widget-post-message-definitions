module StringRefinement
  refine String do
    # @example
    #
    #   strip_margin(<<-TXT
    #     |this is some
    #     |  fancy
    #     |    text that I am
    #     |writing.
    #   TXT)
    #
    #   # => "
    #   # => this is some
    #   # =>   fancy
    #   # =>     text that I am
    #   # => writing.
    #   # => "
    #
    # @param [String] margin (default: "|")
    # @return [String]
    def strip_margin(margin = "|")
      self.split("\n").map do |line|
        line.gsub(/^\s+#{Regexp.quote(margin)}/, "")
      end.join("\n")
    end

    # @example
    #
    #   classify("hi_there") # => "HiThere"
    #   classify("hi_thereMan") # => "HiThereMan"
    #
    # @return [String]
    def classify
      self.gsub("/", "_").split("_").collect do |word|
        head = word[0].upcase
        tail = word.split("").drop(1)
        head + tail.join
      end.join
    end

    # @example
    #
    #   "hi_there".titleize # => "Hi there"
    #   "hi thereMan".titleize # => "Hi there man"
    #   "hi_there_Man".titleize # => "Hi there man"
    #   "hi there Man".titleize # => "Hi there man"
    #
    # @return [String]
    def titleize
      words = self.gsub("/", " ")
                  .gsub("_", " ")
                  .gsub(/([a-z])([A-Z])/, '\1 \2')
                  .split(" ")
                  .map(&:downcase)

      return "" if words.empty?

      [words.first.capitalize, *words.drop(1)].join(" ")
    end

    # @example
    #
    #   surround("age", "\"") # => "\"age\""
    #   surround("1", "[", "]") # => "[1]"
    #
    # @param [String] lhs
    # @param [String] rhs, (default: lhs)
    # @return [String]
    def surround(lhs, rhs = lhs)
      "#{lhs}#{self}#{rhs}"
    end

    # @example
    #
    #   "on".normalize_keywords # => "\"age\""
    #   "onMfa".normalize_keywords # => "\"onMFA\""
    #   "onOauth".normalize_keywords # => "\"onOAuth\""
    #
    # @param [String] string
    # @return [String]
    def normalize_keywords
      self.gsub("Oauth", "OAuth")
          .gsub(/\soauth/i, " OAuth")
          .gsub("Mfa", "MFA")
          .gsub(/\smfa/i, " MFA")
    end
  end
end
