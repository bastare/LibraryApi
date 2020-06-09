# typed: false
# frozen_string_literal: true

require_relative '../../helpers/configuration'
# Module contain classes that represent Data Accsess Layer
module DAL
  # Class represent abstraction for DAL entites
  class Repository
    attr_reader :path

    def initialize
      @path = create_db(Helper.db_path)
    end

    def create(entitys)
      entitys.uniq!(&:id)

      file = File.new(@path, 'w')

      entitys.each do |entity|
        next if entity.nil?

        entity = [entity] unless entity.is_a? Array

        file.write(entity.to_yaml.gsub(/^---/, ''))
      end
    ensure
      file&.close
    end

    def fetch_all
      YAML.load_file(@path) || nil
    end

    def fetch_entity(id)
      result = fetch_all&.select { |i| i&.id == id }

      result&.first
    end

    private

    def create_db(db_path)
      db_path ||= './db'

      Dir.mkdir db_path unless Dir.exist?(db_path)

      entity_name = self.class.name[/(?<=\W)[A-Z][a-z]+/]&.downcase || raise(StandardError, 'Wrong entity name')

      db_path = "#{db_path}/#{entity_name}.yaml"

      File.new(db_path, 'w') unless File.exist? db_path

      db_path
    end
  end
end
