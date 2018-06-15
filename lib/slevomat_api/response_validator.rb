module SlevomatApi
  class ResponseValidator

    def validate_response(response)
      return response if (200..299) === response.http_status

      if (400..499) === response.http_status
        raise Error::ResponseError.new("Slevomat API returned 404 - Page not found. Please check your API URL.") if response.http_status == 404
        raise Error::ResponseError.new("Slevomat API invalid #{response.http_status} response: missing status.") unless response.response_status.present?
        raise Error::ResponseError.new("Slevomat API invalid #{response.http_status} response: missing messages.") unless response.response_message.present?
        case response.response_status
          when InvalidRequestType::BAD_REQUEST
            raise Error::BadRequestError.new(response.response_message)
          when InvalidRequestType::INVALID_CREDENTIALS
            raise Error::InvalidCredentials.new(response.response_message)
          when InvalidRequestType::ORDER_NOT_FOUND
            raise Error::OrderNotFound.new(response.response_message)
          when InvalidRequestType::ORDER_ITEM_NOT_FOUND
            raise Error::OrderItemNotFound.new(response.response_message)
          when InvalidRequestType::INVALID_STATUS_CHANGE
            raise Error::InvalidStatusChange.new(response.response_message)
          when InvalidRequestType::INVALID_CANCEL
            raise Error::InvalidCancel.new(response.response_message)
          when InvalidRequestType::OTHER_ERROR
            raise Error::OtherError.new(response.response_message)
          when InvalidRequestType::ORDER_NOT_EXPORTED
            raise Error::OrderNotExported.new(response.response_message)
          else
            raise Error::DefaultError.new(response.response_message)
        end
      else
        raise Error::ResponseError.new("Slevomat API responded with unexpected HTTP status code: #{response.http_status}.")
      end
    end

  end
end