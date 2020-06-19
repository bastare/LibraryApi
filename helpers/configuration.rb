# frozen_string_literal: true

require_relative '../index'

module Helper
  module Configuration
    CONFIGURATION_FILE = 'appsetings.json'
    DEFAULT_OPTIONS    = { dbPath: './db' }.freeze

    class << self
      def db_path
        create_settings unless File.exist? CONFIGURATION_FILE

        JSON.parse(File.read(CONFIGURATION_FILE))[DEFAULT_OPTIONS.keys.first] || DEFAULT_OPTIONS.values.first
      end

      private

      def create_settings
        File.open(CONFIGURATION_FILE, 'w') { |file| file.write(DEFAULT_OPTIONS.to_json) }
      end
    end
  end
end
