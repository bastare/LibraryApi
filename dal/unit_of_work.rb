# typed: true
# frozen_string_literal: true

require_relative '../index'

require 'yaml'

# Module contain classes that represent Data Accsess Layer
module DAL
  # Unit of DAL entites
  class UnitOfWork
    attr_reader :author, :book, :order, :reader

    def initialize
      @path = DAL.create_db(Helper.db_path)

      @author = AuthorDAL.new @path
      @book   = BookDAL.new   @path
      @order  = OrderDAL.new  @path
      @reader = ReaderDAL.new @path
    end

    def save(*entitys)
      # unique_by_id! entitys

      entitys&.flatten! || raise(ArgumentNilError, 'Value is nil')

      File.open(@path, 'w') { |f| f.write(entitys.to_yaml) }
    end

    private

    def unique_by_id!(*entitys)
      entitys.dig(0).each { |array| array.uniq!(&:id) }
    end
  end
end
