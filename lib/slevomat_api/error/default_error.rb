module SlevomatApi
  module Error
    class DefaultError < StandardError

      attr_reader :message

      def initialize(message = nil)
        @message = message
      end

    end
  end
end