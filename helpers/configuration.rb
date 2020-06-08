# frozen_string_literal: true

require 'json'

module Helper
  class << self
    def db_path
      create_settings({ dbPath: './db' })

      JSON.parse(File.read('appsetings.json'))['dbPath'] || './db'
    end

    private

    def create_settings(opt)
      File.open('appsetings.json', 'w') { |f| f.write(opt.to_json) } unless File.exist? 'appsetings.json'
    end
  end
end
