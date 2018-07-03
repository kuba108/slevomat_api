require 'faraday'
require 'faraday_middleware'

module SlevomatApi
  class RequestMaker

    def initialize(partner_token, api_secret, timeout = 30)
      @partner_token = partner_token
      @api_secret = api_secret
      @timeout = timeout
      @response_validator = ResponseValidator.new
    end

    def send_post_request(url, body = nil)
      request = Request.new(:post, url, build_header, body.to_json)
      connection = create_connection(url, request.headers)
      raw_response = connection.post do |req|
        req.body = request.body
      end
      response = build_response(raw_response)
      @response_validator.validate_response(response)
      true
    end

    # Creates request object.
    def build_response(raw_response, ignore_body = false)
      if ignore_body
        Response.new(raw_response.status)
      else
        Response.new(raw_response.status, raw_response.body)
      end
    end

    private

    # Builds HTTP header.
    def build_header
      {
        'X-PartnerToken': @partner_token,
        'X-ApiSecret': @api_secret,
        'User-Agent': "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}",
        'Content-Type': 'application/json'
      }
    end

    # Sets default options.
    def default_options
      {
        allow_redirects: false,
        verify: true,
        decode_content: true,
        expect: false,
        timeout: @timeout
      }
    end

    def create_connection(url, headers)
      Faraday.new(url: url, headers: headers) do |conn|
        conn.request  :json
        conn.response :logger                  # log requests to STDOUT
        conn.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

  end
end