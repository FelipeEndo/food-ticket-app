module DataFileContentHelper
  def regex_match(string, regex)
    string.match Regexp.new(regex)
  end
end