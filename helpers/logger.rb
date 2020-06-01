# frozen_string_literal: true

# Module contain some extended logic for difference purpose
module Helper
  # Module contain methods for console outputs
  module Logger
    def self.out(input, key1, key2, tittle)
      p tittle

      input.each { |res| p "#{res[key1]&.id} -> #{res[key2]}" }
    end
  end
end
