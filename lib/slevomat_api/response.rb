require 'json'

module SlevomatApi
  class Response

    attr_reader :http_status, :body

    def initialize(http_status, body = nil)
      @http_status = http_status
      # Tries to parse body, which should be JSON
      # when http status is 2xx or 4xx kind and not 404 - page not found.
      if (200..299) === @http_status || ((400..499) === @http_status && @http_status != 404)
        @body = parse_body(body)
      end
    end

    def response_status
      @body['status'] if @body.present?
    end

    def response_message
      @body['messages'] if @body.present?
    end

    private

    def parse_body(body)
      JSON.parse(body)
    rescue
      raise Error::ResponseParsing.new
    end

  end
end