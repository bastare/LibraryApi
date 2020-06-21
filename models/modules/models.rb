# frozen_string_literal: true

module Models
  class << self
    def fetch_klass(klass_name)
      constants.map(&method(:const_get)).grep(Class)&.find do |i|
        i.name.match(/(?<=::)#{Regexp.quote(klass_name)}$/)
      end
    end
  end
end
