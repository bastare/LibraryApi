# frozen_string_literal: true

require_relative '../../index'

# Module contain classes that represent Data Accsess Layer
module DAL
  DB_NAME = 'db'

  class << self
    def create_db(db_folder)
      raise ArgumentNilError, 'Wrong conf' if db_folder.nil?

      db_path = form_path(db_folder)

      File.new(db_path, 'w') unless File.exist? db_path

      db_path
    end

    private

    def form_path(db_folder)
      Dir.mkdir db_folder unless Dir.exist?(db_folder)

      "#{db_folder}/#{DB_NAME}.yaml"
    end
  end

  class ArgumentNilError < ArgumentError
  end
end
