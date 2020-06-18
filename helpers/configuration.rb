# frozen_string_literal: true

require_relative '../index'

module Helper
  class << self
    def db_path
      create_settings unless File.exist? 'appsetings.json'

      JSON.parse(File.read('appsetings.json'))['dbPath'] || './db'
    end

    private

    def create_settings
      default_options = { dbPath: './db' }

      File.open('appsetings.json', 'w') { |f| f.write(default_options.to_json) }
    end
  end
end
