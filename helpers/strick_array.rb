# frozen_string_literal: true

module Helper
  module StrickArray
    refine Array do
      WrongTypeError = Class.new(ArgumentError)

      alias_method :push_old,        :push
      alias_method :single_push_old, :<<

      def push(*args)
        args.flatten!

        type_validation! args

        push_old(*args)
      end

      def <<(item)
        type_validation item

        single_push_old(item)
      end

      private

      def type_validation!(*args)
        args.flatten!

        type = first ? first.class : BasicObject

        raise(WrongTypeError, "Wrong type #{args}") unless args.all? { |entite| entite.is_a? type }
      end
    end
  end
end
