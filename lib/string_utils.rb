module StringUtils
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
  # @param [String] string
  # @param [String] margin (default: "|")
  # @return [String]
  def self.strip_margin(string, margin = "|")
    string.split("\n").map do |line|
      line.gsub(/^\s+#{Regexp.quote(margin)}/, "")
    end.join("\n")
  end

  # @example
  #
  #   classify("hi_there") # => "HiThere"
  #   classify("hi_thereMan") # => "HiThereMan"
  #
  # @param [String] string
  # @return [String]
  def classify(string)
    string.to_s.split("_").collect do |word|
      head = word[0].upcase
      tail = word.split("").drop(1)
      head + tail.join
    end.join
  end

  # @example
  #
  #   surround("age", "\"") # => "\"age\""
  #   surround("1", "[", "]") # => "[1]"
  #
  # @param [String] string
  # @param [String] lhs
  # @param [String] rhs, (default: lhs)
  # @return [String]
  def surround(string, lhs, rhs = lhs)
    "#{lhs}#{string}#{rhs}"
  end
end
