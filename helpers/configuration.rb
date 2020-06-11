# frozen_string_literal: true

require_relative '../index'

# Module contain some extended logic for difference purpose
module Helper
  class << self
    def db_path
      create_settings

      JSON.parse(File.read('appsetings.json'))['dbPath'] || './db'
    end

    private

    # Create default settings, if they doesn`t exist
    def create_settings
      default_opt = { dbPath: './db' }

      File.open('appsetings.json', 'w') { |f| f.write(default_opt.to_json) } unless File.exist? 'appsetings.json'
    end
  end
end
