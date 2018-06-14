module SlevomatApi
  class Response

    attr_reader :status_code, :body

    def initialize(status_code, body = nil)
      @status_code = status_code
      @body = body
    end

  end
end