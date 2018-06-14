require 'faraday'
require 'json'

module SlevomatApi
  class RequestMaker

    API_HOST  = 'https://www.slevomat.cz/'.freeze
    HEADER_PARTNER_TOKEN = 'X-PartnerToken'.freeze
    HEADER_API_SECRET = 'X-ApiSecret'.freeze
    HEADER_USER_AGENT = 'User-Agent'.freeze

    def initialize(client, timeout = 30)
      @client = client
      @timeout = timeout
    end

    def send_post_request(url, options = {}, body = nil)
      request = Request.new(:post, url, build_header, body.to_json)
      options = default_options.merge(options)
      #raw_response = @client.send_request(request, options)
      connection = create_connection(API_HOST, request.headers)
      response = connection.post url, options
      get_response(response)
    end

    # Creates request object.
    def get_response(raw_response, ignore_body = false)
      if ignore_body
        Response.new(raw_response.status)
      else
        Response.new(raw_response.status, parse_body(raw_response.body))
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

    def parse_body(body)
      JSON.parse(body)
    rescue
      raise Error::ResponseParsing.new
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