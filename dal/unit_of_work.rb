# typed: true
# frozen_string_literal: true

require_relative '../index'

module DAL
  class UnitOfWork
    attr_reader :author, :book, :order, :reader

    def initialize
      @path = DAL.create_db(Helper::Configuration.db_path)

      @author = AuthorDAL.new @path
      @book   = BookDAL.new   @path
      @order  = OrderDAL.new  @path
      @reader = ReaderDAL.new @path
    end

    def save(*entitys_lists)
      index_validation entitys_lists

      entitys_lists.flatten!

      File.open(@path, 'w') { |file| file.write(entitys_lists.to_yaml) }
    end

    private

    def index_validation(entitys_lists)
      raise Error::ArgumentNilError, 'Value is nil' if entitys_lists.nil?

      entitys_lists.each do |entitys|
        unless entitys.uniq(&:id).length == entitys.length
          raise(Error::IndexDuplicateError, "Collection of #{entitys.first.class} contain entity, with duplicate index")
        end
      end
    end
  end
end
