require 'faraday'
require 'faraday_middleware'

module SlevomatApi
  class RequestMaker

    #API_HOST  = 'https://www.slevomat.cz/'.freeze
    HEADER_PARTNER_TOKEN = 'X-PartnerToken'.freeze
    HEADER_API_SECRET = 'X-ApiSecret'.freeze
    HEADER_USER_AGENT = 'User-Agent'.freeze

    def initialize(client, timeout = 30)
      @client = client
      @timeout = timeout
      @response_validator = ResponseValidator.new
    end

    def send_post_request(url, body = nil, options = {})
      request = Request.new(:post, url, build_header, body.to_json)
      #options = default_options.merge(options)
      connection = create_connection(url, request.headers)
      raw_response = connection.post
      response = build_response(raw_response)
      debugger
      @response_validator.validate_response(response)
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
        'X-PartnerToken': @client.partner_token,
        'X-ApiSecret': @client.api_secret,
        'User-Agent': "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}"
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