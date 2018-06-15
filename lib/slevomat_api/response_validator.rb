module SlevomatApi
  class ResponseValidator

    def validate_response(response)
      return if match?(response.status, '^2')

      if match?(response.status, '^4')
        raise Error::ResponseError.new("Slevomat API invalid #{response.status} response: missing status.") unless response.body.status.present?
        raise Error::ResponseError.new("Slevomat API invalid #{response.status} response: missing messages.") unless response.body.message.present?
        case response.body.status
          when 'InvalidRequestType::BAD_REQUEST'
            raise Error::BadRequestError.new(response.body.message)
          when 'InvalidRequestType::INVALID_CREDENTIALS'
            raise Error::InvalidCredentials.new(response.body.message)
          when 'InvalidRequestType::ORDER_NOT_FOUND'
            raise Error::OrderNotFound.new(response.body.message)
          when 'InvalidRequestType::ORDER_ITEM_NOT_FOUND'
            raise Error::OrderItemNotFound.new(response.body.message)
          when 'InvalidRequestType::INVALID_STATUS_CHANGE'
            raise Error::InvalidStatusChange.new(response.body.message)
          when 'InvalidRequestType::INVALID_CANCEL'
            raise Error::InvalidCancel.new(response.body.message)
          when 'InvalidRequestType::OTHER_ERROR'
            raise Error::OtherError.new(response.body.message)
          when 'InvalidRequestType::ORDER_NOT_EXPORTED'
            raise Error::OrderNotExported.new(response.body.message)
          else
            raise Error::DefaultError.new(response.body.message)
        end
      else
        raise Error::ResponseError.new("Slevomat API responded with unexpected HTTP status code: #{response.status}.")
      end
    end

    private

    def match?(str, regexp)
      str.match(regexp).is_a? MatchData
    end

  end
end