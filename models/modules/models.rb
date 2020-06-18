# frozen_string_literal: true

module Models
  class << self
    def fetch_class(class_name)
      constants.map(&method(:const_get)).grep(Class)&.find do |i|
        i.name.match(/(?<=::)#{Regexp.quote(class_name)}$/)
      end
    end
  end
end
